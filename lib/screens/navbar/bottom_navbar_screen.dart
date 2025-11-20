import 'package:chatt_app/screens/friends/friends_screen.dart';
import 'package:chatt_app/screens/home/home_screen.dart';
import 'package:chatt_app/screens/profile/profile_screen.dart';
import 'package:chatt_app/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  int selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = [HomeScreen(), FriendsScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavbar(
        onTap: navigateBottomBar,
        currentIndex: selectedIndex,
        items: const [
          NavItem(asset: 'assets/images/chat_icon.png', label: 'Chats'),
          NavItem(icon: Icons.group_rounded, label: 'Friends'),
          NavItem(icon: Icons.person_rounded, label: 'Profile'),
        ],
      ),

      body: screens[selectedIndex],
    );
  }
}
