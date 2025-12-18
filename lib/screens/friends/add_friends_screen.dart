import 'package:flutter/material.dart';
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

  // TEMP dummy users (replace with Firestore later)
  final List<Map<String, String>> users = [
    {'name': 'Ayesha', 'bio': 'Flutter dev ✨'},
    {'name': 'Muneeb', 'bio': 'Coffee + Code ☕'},
    {'name': 'Dua', 'bio': 'UI Lover 💖'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((u) {
      return u['name']!.toLowerCase().contains(_query) ||
          u['bio']!.toLowerCase().contains(_query);
    }).toList();

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
      body: Column(
        children: [
          GlitzySearchBar(
            controller: searchController,
            hint: 'Search by name or email',
            onChanged: (value) {
              setState(() => _query = value.toLowerCase());
            },
          ),

          const SizedBox(height: 12),

          Expanded(
            child: filteredUsers.isEmpty
                ? const Center(child: Text('No users found'))
                : ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return FriendTile(
                        name: user['name']!,
                        bio: user['bio']!,
                        avatarColor: Colors.pink[200]!,
                        actionIcon: Icons.person_add,
                        onActionTap: () {
                          // later → send friend request
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
