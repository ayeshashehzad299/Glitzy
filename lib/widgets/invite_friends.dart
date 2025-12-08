import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InviteFriendsButton extends StatelessWidget {
  const InviteFriendsButton({
    super.key,
    required this.label,
    this.onTap,
    this.onIconTap,
    this.backgroundColor = const Color(0xFFFFF4F7),
    this.borderColor = const Color(0xFFFF69B4),
    this.textColor = const Color(0xFF8E2A6C),
    this.iconColor = const Color(0xFFFF69B4),
  });

  final String label;
  final VoidCallback? onTap;
  final VoidCallback? onIconTap;

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 1.5),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        GestureDetector(
          onTap: onIconTap ?? onTap,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Icon(Icons.person_add_alt_1, color: iconColor),
          ),
        ),
      ],
    );
  }
}
