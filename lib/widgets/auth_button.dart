import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.onPressed, required this.label});

  final Future<void> Function()? onPressed;
  final String label;

  static const Color hotPink = Color(0xFFFF69B4);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (onPressed != null) {
          await onPressed!();
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: hotPink, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/google.png', height: 22),
            const SizedBox(width: 10),
            Text(
              'Google',
              style: GoogleFonts.quicksand(
                fontSize: 20,
                color: const Color(0xFF8E2A6C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
