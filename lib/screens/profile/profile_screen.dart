import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color blushPink = Color(0xFFFFF4F7);
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color darkText = Color(0xFF8E2A6C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blushPink,
      appBar: AppBar(
        backgroundColor: blushPink,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 80,
        titleSpacing: 30,
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            'Profile',
            style: GoogleFonts.chilanka(
              color: hotPink,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
