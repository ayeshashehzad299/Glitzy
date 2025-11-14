import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthLabel extends StatelessWidget {
  const AuthLabel({super.key, required this.text, this.leftPadding = 7.0});

  final String text;
  final double leftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            color: const Color(0xFF8E2A6C),
          ),
        ),
      ),
    );
  }
}
