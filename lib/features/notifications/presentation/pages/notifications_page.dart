// lib/features/notifications/presentation/pages/notifications_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String _activeFilter = 'All';

  final List<String> _filters = [
    'All 56',
    'Likes & roses',
    'Matches',
    'Gifts',
    'Date Invites',
  ];

  // List of mock notifications matching Screenshot 1 exactly
  final List<Map<String, dynamic>> _allNotifications = [
    {
      'id': '1',
      'type': 'rose',
      'name': 'Dev',
      'age': 27,
      'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80',
      'title': 'sent you a Rose',
      'content': '“Your trekking photos sold me — let’s swap trail stories.”',
      'time': '12 min ago',
      'unread': true,
      'badgeIcon': '🌹',
      'actionLabel': 'View profile',
    },
    {
      'id': '2',
      'type': 'compliment',
      'name': 'Arjun',
      'age': 28,
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
      'title': 'complimented your About',
      'content': '“Equally driven and equally curious — that line got me.”',
      'time': '3 h ago',
      'unread': false,
      'badgeIcon': '💬',
    },
    {
      'id': '3',
      'type': 'match',
      'name': 'Aanya',
      'age': 25,
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80',
      'title': 'It’s a match with Aanya, 25',
      'content': 'You both liked each other. Say hello before the spark fades.',
      'time': '40 min ago',
      'unread': true,
      'badgeIcon': '✓',
      'actionLabel': 'Send a message',
    },
    {
      'id': '4',
      'type': 'message',
      'name': 'Elena',
      'age': 23,
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
      'title': 'sent you a message',
      'content': '“Haha okay that café pick was elite. When are you free?”',
      'time': '1 h ago',
      'unread': true,
      'badgeIcon': '💬',
    },
    {
      'id': '5',
      'type': 'invite_approved',
      'name': 'Kabir',
      'age': 28,
      'avatar': '',
      'title': 'approved your date request',
      'content': 'Coffee at Blue Tokai · Today, 7:00 PM · Koregaon Park',
      'time': '2 h ago',
      'unread': true,
      'isCalendar': true,
      'actionLabel': 'Open chat',
    },
  ];

  void _markAllRead() {
    setState(() {
      for (var notif in _allNotifications) {
        notif['unread'] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F5), // Premium warm off-white cream background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            _buildFiltersRow(),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // TODAY section label
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 12),
                    child: Text(
                      'TODAY',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.black38,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),

                  // Notification items
                  ..._allNotifications.map((notif) => _buildNotificationCard(notif)),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
      child: Row(
        children: [

          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: AppTextStyles.headingMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '9 new updates',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _markAllRead,
            child: Text(
              'Mark all read',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersRow() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _activeFilter == filter || (_activeFilter == 'All' && filter.startsWith('All'));
          return GestureDetector(
            onTap: () => setState(() => _activeFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF263238) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Column
              Stack(
                clipBehavior: Clip.none,
                children: [
                  if (notif['isCalendar'] == true)
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.calendar_today_rounded, color: Colors.orangeAccent, size: 24),
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(notif['avatar']),
                    ),
                  if (notif['badgeIcon'] != null)
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: notif['badgeIcon'] == '✓'
                              ? const Color(0xFF66BB6A)
                              : const Color(0xFFFFD54F),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Text(
                          notif['badgeIcon'],
                          style: TextStyle(
                            fontSize: 10,
                            color: notif['badgeIcon'] == '✓' ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),

              // Content Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Text
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.5,
                          color: AppColors.textPrimary,
                          fontFamily: 'Poppins',
                        ),
                        children: [
                          TextSpan(
                            text: notif['type'] == 'match' || notif['type'] == 'invite_approved'
                                ? notif['title']
                                : '${notif['name']}, ${notif['age']} ',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          if (notif['type'] != 'match' && notif['type'] != 'invite_approved')
                            TextSpan(
                              text: notif['title'],
                              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Body Content
                    Text(
                      notif['content'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.black87,
                        fontSize: 13.5,
                        height: 1.4,
                        fontStyle: notif['type'] == 'rose' || notif['type'] == 'compliment' || notif['type'] == 'message'
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Time Text
                    Text(
                      notif['time'],
                      style: AppTextStyles.labelSmall.copyWith(color: AppColors.textHint, fontSize: 11),
                    ),

                    // Action buttons
                    if (notif['actionLabel'] != null) ...[
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          // Handle corresponding actions
                          setState(() {
                            notif['unread'] = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            notif['actionLabel'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Unread indicator dot
          if (notif['unread'] == true)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
