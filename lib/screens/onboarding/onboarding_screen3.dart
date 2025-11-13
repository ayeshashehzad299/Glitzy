import 'package:chatt_app/screens/auth/login_screen.dart';
import 'package:chatt_app/screens/auth/signup_screen.dart';
import 'package:chatt_app/widgets/custom_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen3 extends StatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
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
                  'assets/images/onboarding-3.png',
                  height: 350,
                  width: 350,
                ),
                SizedBox(height: 10),
                Text(
                  'The Best Conversations',
                  style: GoogleFonts.chilanka(
                    color: hotPink,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                Text(
                  'Your friends are always a \ntap away. Chat whenever \nthe mood strikes.',
                  style: GoogleFonts.quicksand(color: darkText, fontSize: 21),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                CustomNavigationButton(
                  text: 'Start Sparkling',
                  destination: SignupScreen(),
                ),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: GoogleFonts.chilanka(
                          color: hotPink,
                          fontSize: 16,
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                          child: Text(
                            "Log in",
                            style: GoogleFonts.chilanka(
                              color: Colors.pink,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
