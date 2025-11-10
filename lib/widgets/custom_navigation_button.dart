import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavigationButton extends StatelessWidget {
  const CustomNavigationButton({
    super.key,
    required this.text,
    required this.destination,
  });

  final String text;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
      },
      child: SizedBox(
        width: 300,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFFF69B4),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.chilanka(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
