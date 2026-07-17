// lib/features/profile/presentation/widgets/lifestyle_grid.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/domain/entities/user_entity.dart';

class LifestyleGrid extends StatelessWidget {
  final UserEntity user;

  const LifestyleGrid({super.key, required this.user});

  static const List<_LifestyleItem> _items = [
    _LifestyleItem(icon: Icons.wine_bar_rounded, label: 'Drinks', value: 'Socially'),
    _LifestyleItem(icon: Icons.smoking_rooms_rounded, label: 'Smoke', value: 'Never'),
    _LifestyleItem(icon: Icons.fitness_center_rounded, label: 'Exercise', value: '3x/week'),
    _LifestyleItem(icon: Icons.child_friendly_rounded, label: 'Kids', value: 'Someday'),
    _LifestyleItem(icon: Icons.pets_rounded, label: 'Pets', value: 'Dog lover'),
    _LifestyleItem(icon: Icons.school_rounded, label: 'Education', value: 'Graduate'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lifestyle', style: AppTextStyles.sectionHeader),
          const SizedBox(height: 12),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(item.icon, color: AppColors.primary, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item.label,
                              style: AppTextStyles.labelSmall
                                  .copyWith(fontSize: 10)),
                          Text(item.value,
                              style: AppTextStyles.labelMedium
                                  .copyWith(fontSize: 12),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LifestyleItem {
  final IconData icon;
  final String label;
  final String value;
  const _LifestyleItem(
      {required this.icon, required this.label, required this.value});
}
