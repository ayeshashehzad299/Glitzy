import 'dart:async';

import 'package:chatt_app/screens/onboarding/onboarding_screen1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Color blushPink = Color.fromARGB(255, 253, 240, 243);
  static const Color textPurple = Color(0xFF8E2A6C);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen1()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final logoTopPosition = screenHeight * 0.20;
    const logoSize = 320.0;

    return Scaffold(
      backgroundColor: blushPink,
      body: Stack(
        children: [
          Positioned(
            top: logoTopPosition,
            left: 0,
            right: 18,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: logoSize,
                height: logoSize,
              ),
            ),
          ),
          Positioned(
            top: logoTopPosition + 280,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Where Conversations Sparkle',
                style: GoogleFonts.chilanka(
                  color: textPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
