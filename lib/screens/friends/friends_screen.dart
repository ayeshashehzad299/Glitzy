import 'package:chatt_app/widgets/invite_friends.dart';
import 'package:chatt_app/widgets/search_bar.dart';
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
  static const Color darkText = Color(0xFF8E2A6C);

  final List<Map<String, String>> _allFriends = [
    {'username': 'Ayesha', 'email': 'ayesha@example.com'},
    {'username': 'Muneeb', 'email': 'muneeb@example.com'},
    {'username': 'Dua', 'email': 'dua@example.com'},
  ];

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _allFriends.where((f) {
      final q = _query.toLowerCase();
      return f['username']!.toLowerCase().contains(q) ||
          f['email']!.toLowerCase().contains(q);
    }).toList();

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
                // search logic
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: InviteFriendsButton(label: 'Invite Your Friend'),
            ),
          ],
        ),
      ),
    );
  }
}
