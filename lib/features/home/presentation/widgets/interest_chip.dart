// lib/features/home/presentation/widgets/interest_chip.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class InterestChip extends StatelessWidget {
  final String label;
  final bool isLight;

  const InterestChip({
    super.key,
    required this.label,
    this.isLight = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isLight
            ? Colors.white.withOpacity(0.25)
            : AppColors.secondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isLight ? Colors.white38 : AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.chip.copyWith(
          color: isLight ? Colors.white : AppColors.primary,
          fontSize: 11,
        ),
      ),
    );
  }
}
