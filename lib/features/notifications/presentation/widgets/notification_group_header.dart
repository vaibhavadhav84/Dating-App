// lib/features/notifications/presentation/widgets/notification_group_header.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationGroupHeader extends StatelessWidget {
  final String title;

  const NotificationGroupHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.notifGroupHeader,
      ),
    );
  }
}
