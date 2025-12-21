import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';

class AddAFriendScreen extends StatefulWidget {
  const AddAFriendScreen({super.key});

  @override
  State<AddAFriendScreen> createState() => _AddAFriendScreenState();
}

class _AddAFriendScreenState extends State<AddAFriendScreen> {
  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);

  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blushPink,

      appBar: AppBar(
        backgroundColor: blushPink,
        elevation: 0,
        title: Text(
          "Add a Friend",
          style: GoogleFonts.chilanka(
            color: hotPink,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your friend's email 👇",
              style: GoogleFonts.quicksand(
                color: Colors.pink[700],
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  hintText: "friend@email.com",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.email_outlined, color: hotPink),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: hotPink, width: 1.4),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: hotPink, width: 1.4),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hotPink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                ),

                onPressed: _sending
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;

                        final String email = emailController.text.trim();
                        final auth = FirebaseAuth.instance;
                        final firestore = FirebaseFirestore.instance;
                        final currentUser = auth.currentUser;

                        if (currentUser == null) return;

                        setState(() => _sending = true);

                        try {
                          // 1️⃣ Find user by email
                          final query = await firestore
                              .collection('users')
                              .where('email', isEqualTo: email)
                              .limit(1)
                              .get();

                          if (query.docs.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("User not found")),
                            );
                            setState(() => _sending = false);
                            return;
                          }

                          final receiver = query.docs.first;
                          final receiverId = receiver.id;

                          // 2️⃣ Prevent sending request to self
                          if (receiverId == currentUser.uid) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "You cannot send request to yourself",
                                ),
                              ),
                            );
                            setState(() => _sending = false);
                            return;
                          }

                          // 3️⃣ Check duplicate friend request
                          final existing = await firestore
                              .collection("friend_requests")
                              .where("senderId", isEqualTo: currentUser.uid)
                              .where("receiverId", isEqualTo: receiverId)
                              .where("status", isEqualTo: "pending")
                              .get();

                          if (existing.docs.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Friend request already sent"),
                              ),
                            );
                            setState(() => _sending = false);
                            return;
                          }

                          // 4️⃣ Create request document
                          await firestore.collection("friend_requests").add({
                            "senderId": currentUser.uid,
                            "receiverId": receiverId,
                            "receiverEmail": email,
                            "status": "pending",
                            "createdAt": FieldValue.serverTimestamp(),
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Friend request sent to $email"),
                            ),
                          );

                          emailController.clear();
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Error: $e")));
                        }

                        setState(() => _sending = false);
                      },

                child: _sending
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Send Request",
                        style: GoogleFonts.quicksand(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
