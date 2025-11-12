import 'package:flutter/material.dart';

// This widget creates the distinctive pink, wavy-shaped button
// with a forward arrow icon, used for navigation in the onboarding flow.
class WavyIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size; // Size controls both width and height for a circular shape

  // Custom colors defined globally in the Glitzy design system
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color lightPinkFill = Color(0xFFFFC0E4);

  const WavyIconButton({
    super.key,
    required this.onPressed,
    this.size = 80.0, // Default size for a prominent navigation button
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/wavy-circle.png',
              width: size,
              height: size,
              color: hotPink,
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }
}
