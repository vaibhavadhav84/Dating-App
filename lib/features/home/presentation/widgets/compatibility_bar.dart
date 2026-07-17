// lib/features/home/presentation/widgets/compatibility_bar.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CompatibilityBar extends StatelessWidget {
  final int percentage;

  const CompatibilityBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 4,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$percentage% Match',
          style: AppTextStyles.compatLabel.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
