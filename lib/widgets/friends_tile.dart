import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendTile extends StatelessWidget {
  final String name;
  final String bio;
  final Color avatarColor;
  final VoidCallback onActionTap;
  final IconData actionIcon;

  const FriendTile({
    super.key,
    required this.name,
    required this.bio,
    required this.avatarColor,
    required this.onActionTap,
    required this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(radius: 22, backgroundColor: avatarColor),

            const SizedBox(width: 12),

            // Name + status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF8E2A6C),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    bio,
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Action button
            GestureDetector(
              onTap: onActionTap,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFFF69B4),
                child: Icon(actionIcon, size: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
