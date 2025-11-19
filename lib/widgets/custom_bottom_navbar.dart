import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final void Function(int) onTap;
  final int currentIndex;
  const CustomBottomNavbar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFFFFC0CB),
      backgroundColor: Color(0xFFFF69B4),
      onTap: onTap,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: 'Chats'),
      ],
    );
  }
}
