// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:chatt_app/widgets/auth_button.dart';
import 'package:chatt_app/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color darkText = Color(0xFF8E2A6C);

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // final _formKey = GlobalKey<FormState>();

  // final _auth = FirebaseAuth.instance;
  // // final _firestore = FirebaseFirestore.instance;

  // Future<void> signUpUser() async {
  //   if (!_formKey.currentState!.validate()) return;

  //   setState(() => isLoading = true);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blushPink,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
              child: Form(
                // key: _f,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up to Sparkle',
                      style: GoogleFonts.chilanka(
                        color: hotPink,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Just a few taps to start chatting!',
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        color: darkText,
                      ),
                    ),
                    SizedBox(height: 40),

                    AuthButton(label: 'Google'),

                    SizedBox(height: 10),

                    Text('or', style: GoogleFonts.quicksand(fontSize: 16)),

                    SizedBox(height: 10),

                    AuthTextField(
                      hintText: 'UserName',
                      controller: userNameController,
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
