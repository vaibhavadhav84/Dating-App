// lib/features/profile/presentation/widgets/info_section.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/domain/entities/user_entity.dart';

class InfoSection extends StatefulWidget {
  final UserEntity user;

  const InfoSection({super.key, required this.user});

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name, age, verify
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.user.fullName,
                  style: AppTextStyles.displayMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${widget.user.age}',
                style: AppTextStyles.headingLarge
                    .copyWith(color: AppColors.textSecondary),
              ),
              if (widget.user.isVerified) ...[
                const SizedBox(width: 6),
                const Icon(Icons.verified_rounded,
                    color: Color(0xFF4FC3F7), size: 22),
              ],
            ],
          ),
          const SizedBox(height: 8),
          // Location
          Row(
            children: [
              const Icon(Icons.location_on_rounded,
                  color: AppColors.primary, size: 16),
              const SizedBox(width: 4),
              Text(widget.user.location, style: AppTextStyles.bodySmall),
              const SizedBox(width: 12),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.textHint,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${widget.user.distance.toStringAsFixed(1)} km away',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Online status
          if (widget.user.isOnline)
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Online now',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.success),
                ),
              ],
            ),
          const SizedBox(height: 20),
          // About
          Text('About', style: AppTextStyles.sectionHeader),
          const SizedBox(height: 8),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              widget.user.bio,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            secondChild: Text(
              widget.user.bio,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Text(
              _expanded ? 'Show less' : 'Read more',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
