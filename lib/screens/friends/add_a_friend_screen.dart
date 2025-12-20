import 'package:flutter/material.dart';
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

                        setState(() => _sending = true);

                        await Future.delayed(const Duration(seconds: 1));

                        setState(() => _sending = false);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Friend request sent to ${emailController.text}",
                            ),
                          ),
                        );

                        emailController.clear();
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
