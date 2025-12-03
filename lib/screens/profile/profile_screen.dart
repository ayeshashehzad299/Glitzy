import 'package:chatt_app/widgets/auth_primary_button.dart';
import 'package:chatt_app/widgets/profile_avatar.dart';
import 'package:chatt_app/widgets/profile_textfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p; // for extension
import 'dart:typed_data';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final bioController = TextEditingController();

  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color darkText = Color(0xFF8E2A6C);

  final ImagePicker _picker = ImagePicker();
  bool _uploading = false;
  String? _imageUrl;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  // make sure Supabase.initialize(...) is called in your app's entrypoint
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _loadProfile(); // <- call it (not just reference)
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!mounted) return;
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _imageUrl = (data['photoUrl'] as String?)?.isNotEmpty == true
            ? data['photoUrl'] as String?
            : null;
        nameController.text = (data['displayName'] ?? '') as String;
        userNameController.text = (data['userName'] ?? '') as String;
        bioController.text = (data['bio'] ?? '') as String;
      });
    }
  }

  Future<void> _pickAndUploadImage() async {
    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Not signed in')));
      return;
    }

    // pick image
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 1200,
      imageQuality: 80,
    );

    if (file == null) return; // user cancelled

    setState(() => _uploading = true);

    try {
      // read bytes
      final Uint8List bytes = await file.readAsBytes();

      // extension + filename
      final ext = p.extension(file.path);
      final fileName =
          'users/${user.uid}/avatar-${DateTime.now().millisecondsSinceEpoch}$ext';

      // upload as binary to Supabase storage (bucket 'avatars')
      final res = await supabase.storage
          .from('avatars')
          .uploadBinary(
            fileName,
            bytes,
            fileOptions: const FileOptions(contentType: 'image/jpeg'),
          );

      // get public url - handle possible response shapes using dynamic to avoid strict typing mismatch
      final dynamic publicRes = supabase.storage
          .from('avatars')
          .getPublicUrl(fileName);

      String? publicUrl;

      // Different supabase client versions return different shapes. handle common ones:
      try {
        // vX: object with .publicUrl
        publicUrl = (publicRes as dynamic).publicUrl as String?;
      } catch (_) {
        try {
          // vY: object with data: { publicUrl: '...' }
          publicUrl = (publicRes as dynamic).data?['publicUrl'] as String?;
        } catch (_) {
          // fallback: if it's already a String
          if (publicRes is String) publicUrl = publicRes;
        }
      }

      if (publicUrl == null || publicUrl.isEmpty) {
        throw Exception(
          'Could not determine public URL from Supabase response',
        );
      }

      // Save public URL to Firestore (merge so we don't overwrite other fields)
      await _firestore.collection('users').doc(user.uid).set({
        'photoUrl': publicUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      setState(() {
        _imageUrl = publicUrl;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile photo updated')));
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

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'displayName': nameController.text.trim(),
        'userName': userNameController.text.trim(),
        'bio': bioController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile saved')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
    } finally {
      setState(() => _uploading = false);
    }
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
        actions: [
          IconButton(
            onPressed: _saveProfileFields,
            icon: const Icon(Icons.save),
            color: hotPink,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // pass current image url and tap handler to avatar
              ProfileAvatar(
                imageUrl: _imageUrl,
                size: 66,
                onTap: _pickAndUploadImage,
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 40),
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProfileFields,
                style: ElevatedButton.styleFrom(
                  backgroundColor: hotPink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  child: Text('Save'),
                ),
              ),
              const SizedBox(height: 40),
              AuthPrimaryButton(label: 'Save', onTap:),
            ],
          ),
        ),
      ),
    );
  }
}
