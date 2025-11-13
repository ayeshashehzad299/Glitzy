import 'package:chatt_app/screens/auth/login_screen.dart';
import 'package:chatt_app/screens/onboarding/onboarding_screen2.dart';
import 'package:chatt_app/widgets/custom_wavy_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color darkText = Color(0xFF8E2A6C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blushPink,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/onboarding-1.png',
                  height: 350,
                  width: 350,
                ),
                SizedBox(height: 10),
                Text(
                  'Sparkle & Share',
                  style: GoogleFonts.chilanka(
                    color: hotPink,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Send quick replies, fun \nemojis, and share all the \nglittery details with your \nclosest friends.',
                  style: GoogleFonts.quicksand(color: darkText, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 55,
            left: 40,

            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Skip',
                style: GoogleFonts.chilanka(
                  color: hotPink,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child: WavyIconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen2()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
