// lib/features/messages/presentation/widgets/chat_tile.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/avatar_widget.dart';
import '../bloc/messages_state.dart';
import 'unread_badge.dart';

class ChatTile extends StatelessWidget {
  final ChatItem chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final hasUnread = chat.unreadCount > 0;

    return GestureDetector(
      onTap: () => context.push('/chat/${chat.user.id}', extra: chat.user),
      child: Container(
        color:
            hasUnread ? AppColors.unreadBg : AppColors.background,
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            AvatarWidget(
              imageUrl: chat.user.avatarThumb,
              size: 52,
              isOnline: chat.user.isOnline,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.user.fullName,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: hasUnread
                          ? FontWeight.w700
                          : FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: hasUnread
                          ? FontWeight.w500
                          : FontWeight.w400,
                      color: hasUnread
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.timestamp.timeAgo,
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(height: 4),
                UnreadBadge(count: chat.unreadCount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
