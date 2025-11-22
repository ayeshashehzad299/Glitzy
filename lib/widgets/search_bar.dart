import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlitzySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function(String)? onChanged;

  const GlitzySearchBar({
    super.key,
    required this.controller,
    this.hint = "Search friends...",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.15),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        border: Border.all(color: Color(0xFFFF69B4), width: 1.4),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Color(0xFF8E2A6C)),
          SizedBox(width: 5),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.quicksand(
                  fontSize: 18,
                  color: Color(0xFF8E2A6C).withOpacity(0.6),
                ),
              ),
              style: GoogleFonts.quicksand(
                fontSize: 17,
                color: Color(0xFF8E2A6C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
