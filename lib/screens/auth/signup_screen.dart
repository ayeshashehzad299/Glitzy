import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatt_app/screens/auth/login_screen.dart';
import 'package:chatt_app/widgets/auth_button.dart';
import 'package:chatt_app/widgets/auth_label.dart';
import 'package:chatt_app/widgets/auth_primary_button.dart';
import 'package:chatt_app/widgets/auth_text_field.dart';
import 'package:chatt_app/widgets/text_navigation_button.dart';
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

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await _firestore.collection('users').doc(user.user!.uid).set({
        'username': userNameController.text.trim(),
        'email': emailController.text.trim(),
        'uid': user.user!.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully 🎉")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Signup failed')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blushPink,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 17),
              child: Form(
                key: _formKey,
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

                    SizedBox(height: 17),

                    AuthLabel(text: 'UserName'),
                    SizedBox(height: 5),
                    AuthTextField(
                      hintText: 'UserName',
                      controller: userNameController,
                    ),

                    SizedBox(height: 29),
                    AuthLabel(text: 'Email'),
                    SizedBox(height: 5),
                    AuthTextField(
                      hintText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 29),
                    AuthLabel(text: 'Password'),
                    SizedBox(height: 5),
                    AuthTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      isPassword: true,
                    ),

                    SizedBox(height: 3),

                    Text(
                      'Password must at least contain 6 characters',
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: darkText,
                      ),
                    ),

                    SizedBox(height: 40),

                    AuthPrimaryButton(
                      label: isLoading ? 'Loading...' : 'Sign Up',
                      onTap: isLoading
                          ? () {}
                          : () {
                              signUpUser();
                            },
                    ),

                    TextNavigationButton(
                      leadingText: 'Already Have an Account?',
                      actionText: 'Log In',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
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
