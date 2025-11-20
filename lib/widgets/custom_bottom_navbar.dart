import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({
    super.key,
    required this.onTap,
    required this.currentIndex,
    this.items = const [
      NavItem(icon: Icons.chat_rounded, label: 'Chats'),
      NavItem(icon: Icons.group_rounded, label: 'Friends'),
      NavItem(icon: Icons.person_rounded, label: 'Profile'),
    ],
    this.backgroundColor = const Color(0xFFFF69B4),
    this.selectedColor = Colors.white,
    this.unselectedColor = const Color(0xFFFFC0CB),
    this.height = 72,
  });

  final void Function(int) onTap;
  final int currentIndex;
  final List<NavItem> items;

  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: Colors.transparent,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (index) {
              final active = index == currentIndex;
              return NavBarItem(
                item: items[index],
                active: active,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
                onTap: () => onTap(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final IconData? icon;
  final String? asset;
  final String label;

  const NavItem({this.icon, this.asset, required this.label})
    : assert(
        icon != null || asset != null,
        'Either icon or asset must be provided.',
      );
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    required this.item,
    required this.active,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
  });

  final NavItem item;
  final bool active;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: active
                ? selectedColor.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: active ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 180),
                child: item.asset != null
                    ? Image.asset(
                        item.asset!,
                        height: 22,
                        color: active ? selectedColor : unselectedColor,
                      )
                    : Icon(
                        item.icon,
                        size: 22,
                        color: active ? selectedColor : unselectedColor,
                      ),
              ),
              const SizedBox(height: 6),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: active ? selectedColor : unselectedColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
