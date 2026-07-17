// lib/shared/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_outlined, label: 'Home'),
    _NavItem(icon: Icons.play_circle_outline_rounded, label: 'Date Now'),
    _NavItem(icon: Icons.favorite_border_rounded, label: 'Admirers'),
    _NavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Chat'),
    _NavItem(icon: Icons.calendar_today_outlined, label: 'Events'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top:
              BorderSide(color: Colors.black.withValues(alpha: 0.06), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final isSelected = index == currentIndex;
          final color = isSelected ? AppColors.primary : Colors.black87;
          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _items[index].icon,
                    color: color,
                    size: 24,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _items[index].label,
                    style: TextStyle(
                      color: color,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 11.5,
                      letterSpacing: -0.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
