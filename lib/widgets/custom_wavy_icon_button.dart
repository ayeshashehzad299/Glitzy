import 'package:flutter/material.dart';

class WavyIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  static const Color hotPink = Color(0xFFFF69B4);
  static const Color lightPinkFill = Color(0xFFFFC0E4);

  const WavyIconButton({super.key, required this.onPressed, this.size = 80.0});

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
