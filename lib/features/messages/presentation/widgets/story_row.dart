// lib/features/messages/presentation/widgets/story_row.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/avatar_widget.dart';
import '../../../home/domain/entities/user_entity.dart';

class StoryRow extends StatelessWidget {
  final List<UserEntity> stories;

  const StoryRow({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: stories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _AddStoryCard();
          }
          final user = stories[index - 1];
          return Column(
            children: [
              AvatarWidget(
                imageUrl: user.avatarThumb,
                size: 66,
                hasStoryRing: true,
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 66,
                child: Text(
                  user.firstName,
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 11),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AddStoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.divider, width: 1),
          ),
          child: const Icon(
            Icons.add_rounded,
            color: AppColors.primary,
            size: 28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Add Story',
          style: AppTextStyles.labelSmall.copyWith(fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
