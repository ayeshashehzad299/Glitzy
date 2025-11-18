import 'package:chatt_app/screens/auth/signup_screen.dart';
import 'package:chatt_app/widgets/auth_button.dart';
import 'package:chatt_app/widgets/auth_label.dart';
import 'package:chatt_app/widgets/auth_primary_button.dart';
import 'package:chatt_app/widgets/auth_text_field.dart';
import 'package:chatt_app/widgets/text_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color darkText = Color(0xFF8E2A6C);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? v) {
    if (v == null || v.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(v) ? null : 'Enter a valid email';
  }

  String? _passwordValidator(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
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
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 25),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chilanka(
                        color: hotPink,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Log in to start sparkling.',
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        color: darkText,
                      ),
                    ),
                    SizedBox(height: 50),

                    AuthButton(label: 'Google'),

                    SizedBox(height: 20),

                    Text('or', style: GoogleFonts.quicksand(fontSize: 16)),

                    SizedBox(height: 15),

                    AuthLabel(text: 'Email'),
                    SizedBox(height: 5),
                    AuthTextField(
                      hintText: 'Email',
                      controller: emailController,
                      validator: _emailValidator,
                    ),

                    SizedBox(height: 29),

                    AuthLabel(text: 'Password'),
                    SizedBox(height: 5),
                    AuthTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      validator: _passwordValidator,
                    ),

                    SizedBox(height: 40),

                    AuthPrimaryButton(label: 'Login', onTap: () {}),

                    TextNavigationButton(
                      leadingText: 'Don’t Have an account?',
                      actionText: 'Sign Up',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
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
