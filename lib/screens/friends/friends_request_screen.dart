import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({super.key});

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);

  List<Map<String, String>> requests = [
    {"name": "Ayesha", "bio": "Flutter Dev 💖"},
    {"name": "Harry", "bio": "Coffee Lover ☕"},
    {"name": "Dua", "bio": "UI Queen 👑"},
  ];

  void acceptRequest(int index) {
    final user = requests[index]["name"];
    setState(() => requests.removeAt(index));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("You are now friends with $user 🎉")),
    );
  }

  void rejectRequest(int index) {
    final user = requests[index]["name"];
    setState(() => requests.removeAt(index));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("You rejected $user’s request ❌")));
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
        titleSpacing: 10,
        title: Text(
          "Friend Requests",
          style: GoogleFonts.chilanka(
            color: hotPink,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

        child: requests.isEmpty
            ? Center(
                child: Text(
                  "No friend requests yet 💌",
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    color: Colors.pink[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final user = requests[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: hotPink, width: 1.3),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.pink[200],
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user["name"]!,
                                style: GoogleFonts.quicksand(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.pink[800],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user["bio"]!,
                                style: GoogleFonts.quicksand(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            IconButton(
                              onPressed: () => rejectRequest(index),
                              icon: Icon(
                                Icons.close,
                                color: Colors.pink[400],
                                size: 26,
                              ),
                            ),
                            IconButton(
                              onPressed: () => acceptRequest(index),
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.pinkAccent,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
