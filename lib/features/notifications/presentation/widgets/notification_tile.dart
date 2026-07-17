// lib/features/notifications/presentation/widgets/notification_tile.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/avatar_widget.dart';
import '../bloc/notifications_state.dart';

class NotificationTile extends StatelessWidget {
  final NotifItem notif;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notif,
    required this.onTap,
  });

  IconData get _typeIcon {
    return switch (notif.type) {
      NotifType.like => Icons.favorite_rounded,
      NotifType.message => Icons.chat_bubble_rounded,
      NotifType.match => Icons.star_rounded,
      NotifType.superLike => Icons.star_rounded,
    };
  }

  Color get _typeColor {
    return switch (notif.type) {
      NotifType.like => AppColors.primary,
      NotifType.message => const Color(0xFF4FC3F7),
      NotifType.match => AppColors.primary,
      NotifType.superLike => const Color(0xFFFFA726),
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: notif.isRead ? AppColors.background : AppColors.unreadBg,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AvatarWidget(
                  imageUrl: notif.user.avatarThumb,
                  size: 48,
                ),
                Positioned(
                  right: -4,
                  bottom: -4,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: _typeColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(_typeIcon, color: Colors.white, size: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif.title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: notif.isRead
                          ? FontWeight.w400
                          : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.body,
                    style: AppTextStyles.bodySmall,
                  ),
                  if (notif.hasActions) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _ActionPill(
                          label: 'Accept',
                          color: AppColors.primary,
                          onTap: () {},
                        ),
                        const SizedBox(width: 8),
                        _ActionPill(
                          label: 'Decline',
                          color: AppColors.textSecondary,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              notif.timestamp.timeAgo,
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionPill({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: label == 'Accept' ? color : Colors.transparent,
          border: Border.all(color: color, width: 1),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: label == 'Accept' ? Colors.white : color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
