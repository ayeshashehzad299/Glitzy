import 'package:chatt_app/widgets/profile_avatar.dart';
import 'package:chatt_app/widgets/profile_textfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p; // for extension

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color darkText = Color(0xFF8E2A6C);

  final _picker = ImagePicker();
  bool _uploading = false;
  String? _imageUrl;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final supabase = Supabase.instance.client;

  void initState() {
    super.initState();
    _loadProfile;
  }

  Future<void> _loadProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!mounted) return;
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _imageUrl = data['photoUrl'] as String?;
        nameController.text = (data['displayName'] ?? '');
        userNameController.text = (data['userName'] ?? '');
        bioController.text = (data['bio'] ?? '') as String;
      });
    }
  }

  Future<void> _pickAndUploadImage() async {
    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Not Signed in')));
      return;
    }
    final Xfile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 1200,
      imageQuality: 80,
    );

    if (file == null) return; //user cancelled

    setState(() => _uploading = true);

    try {
      final bytes = await file.readAsBytes();

      final ext = p.extension(file.path);
      final fileName =
          'users/${user.uid}/avatar-${DateTime.now().millisecondsSinceEpoch}$ext';

      final res = await supabase.storage
          .from('avatars')
          .uploadBinary(
            fileName,
            bytes,
            fileOptions: FileOptions(contentType: 'image/jpeg'),
          );

      final publicRes = supabase.storage.from('avatars').getPublicUrl(fileName);
      final publicUrl =
          publicRes.data?.publicUrl ??
          publicRes.publicUrl ??
          publicRes['publicUrl'];

      await _firestore.collection('users').doc(user.uid).set({
        'photoUrl': publicUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      setState(() {
        _imageUrl = publicUrl;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile photo updated')));
    } catch (e, st) {
      debugPrint('Supabase upload error: $e\n$st');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() => _uploading = false);
    }
  }

  Future<void> _saveProfileFields() async {
    final user = _auth.currentUser;
    if (user == null) return;
    setState(() => _uploading = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blushPink,
      appBar: AppBar(
        backgroundColor: blushPink,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 80,
        titleSpacing: 30,
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            'Profile',
            style: GoogleFonts.chilanka(
              color: hotPink,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              ProfileAvatar(),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: ProfileTextfields(
                  hintText: 'Name',
                  controller: nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: ProfileTextfields(
                  hintText: 'UserName',
                  controller: userNameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: ProfileTextfields(
                  hintText: 'Write Your Bio',
                  controller: bioController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
