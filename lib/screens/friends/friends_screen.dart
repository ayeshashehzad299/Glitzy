import 'package:chatt_app/screens/friends/add_friends_screen.dart';
import 'package:chatt_app/widgets/friends_tile.dart';
import 'package:chatt_app/widgets/invite_friends.dart';
import 'package:chatt_app/widgets/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  TextEditingController searchController = TextEditingController();

  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);

  final user = FirebaseAuth.instance.currentUser;

  String _query = '';

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  border: Border.all(color: hotPink, width: 1.2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Icon(Icons.notifications_none, color: hotPink),
              ),
              tooltip: 'Notifications',
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            'Friends',
            style: GoogleFonts.chilanka(
              color: hotPink,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Column(
          children: [
            GlitzySearchBar(
              controller: searchController,
              hint: "Search Friends",
              onChanged: (value) {
                setState(() {
                  _query = value.toLowerCase();
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: InviteFriendsButton(
                label: 'Invite Your Friend',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddFriendsScreen()),
                  );
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .collection('friends')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No friends yet'));
                  }

                  final friends = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = (data['displayName'] ?? '').toLowerCase();
                    final bio = (data['bio'] ?? '').toLowerCase();

                    return name.contains(_query) || bio.contains(_query);
                  }).toList();

                  return ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final data =
                          friends[index].data() as Map<String, dynamic>;

                      return FriendTile(
                        name: data['displayName'] ?? '',
                        bio: data['bio'] ?? '',
                        avatarColor: Colors.pink[200]!,
                        actionIcon: Icons.send,
                        onActionTap: () {},
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
