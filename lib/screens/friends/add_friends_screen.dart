import 'package:chatt_app/screens/friends/add_a_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatt_app/widgets/friends_tile.dart';
import 'package:chatt_app/widgets/search_bar.dart';

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({super.key});

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);

  final TextEditingController searchController = TextEditingController();
  String _query = '';

  final currentUser = FirebaseAuth.instance.currentUser;

  /// Send friend request
  Future<void> sendFriendRequest(String toUid) async {
    final fromUid = currentUser!.uid;

    // prevent duplicate requests
    final existing = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('fromUid', isEqualTo: fromUid)
        .where('toUid', isEqualTo: toUid)
        .get();

    if (existing.docs.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Request already sent')));
      return;
    }

    await FirebaseFirestore.instance.collection('friend_requests').add({
      'fromUid': fromUid,
      'toUid': toUid,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Friend request sent')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blushPink,

      appBar: AppBar(
        backgroundColor: blushPink,
        elevation: 0,
        title: Text(
          'Add Friends',
          style: GoogleFonts.chilanka(
            color: hotPink,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: hotPink,
        child: const Icon(Icons.person_add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAFriendScreen()),
          );
        },
      ),
      body: Column(
        children: [
          GlitzySearchBar(
            controller: searchController,
            hint: 'Search users',
            onChanged: (value) {
              setState(() => _query = value.toLowerCase());
            },
          ),

          const SizedBox(height: 12),

          /// USERS LIST
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final name = (data['displayName'] ?? '').toLowerCase();
                  final email = (data['email'] ?? '').toLowerCase();

                  // exclude yourself
                  if (doc.id == currentUser!.uid) return false;

                  return name.contains(_query) || email.contains(_query);
                }).toList();

                if (users.isEmpty) {
                  return const Center(child: Text('No users found'));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final data = users[index].data() as Map<String, dynamic>;
                    final uid = users[index].id;

                    return FriendTile(
                      name: data['displayName'] ?? '',
                      bio: data['bio'] ?? '',
                      avatarColor: Colors.pink[200]!,
                      actionIcon: Icons.person_add,
                      onActionTap: () => sendFriendRequest(uid),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
