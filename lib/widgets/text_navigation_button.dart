import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextNavigationButton extends StatelessWidget {
  const TextNavigationButton({
    super.key,
    required this.leadingText,
    required this.actionText,
    required this.onTap,
  });

  final String leadingText;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            leadingText,
            style: GoogleFonts.quicksand(
              color: const Color(0xFF8E2A6C),
              fontSize: 15,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              " $actionText",
              style: GoogleFonts.quicksand(
                color: const Color(0xFFFF69B4),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
