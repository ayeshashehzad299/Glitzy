import 'package:chatt_app/screens/auth/login_screen.dart';
import 'package:chatt_app/screens/onboarding/onboarding_screen3.dart';
import 'package:chatt_app/widgets/custom_wavy_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color darkText = Color(0xFF5C54A7);

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
                  'assets/images/onboarding-2.png',
                  height: 350,
                  width: 350,
                ),
                SizedBox(height: 10),
                Text(
                  'Your Secret Diary',
                  style: GoogleFonts.chilanka(
                    color: hotPink,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Personalize your profile, \nchoose your favorite pink \nthemes, and decorate your \nchat space just for you.',
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
                  MaterialPageRoute(builder: (context) => OnboardingScreen3()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
