// lib/shared/widgets/online_badge.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class OnlineBadge extends StatelessWidget {
  final double size;

  const OnlineBadge({super.key, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.success,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
    );
  }
}
