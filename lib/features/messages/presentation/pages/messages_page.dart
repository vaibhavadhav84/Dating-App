// lib/features/messages/presentation/pages/messages_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/domain/entities/user_entity.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String _activeFilter = 'All';
  String _searchQuery = '';

  final List<String> _filters = [
    'All',
    'Unread',
    'Online',
    'Nearby',
    'Dating Goals',
  ];

  // Mock New Matches data
  final List<Map<String, String>> _newMatches = [
    {
      'name': 'Sarah',
      'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
      'badge': 'NEW',
    },
    {
      'name': 'Ariya',
      'avatar': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=80',
      'badge': '👑',
    },
    {
      'name': 'Liam',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
      'badge': '',
    },
    {
      'name': 'Chloe',
      'avatar': 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=80',
      'badge': '📹',
    },
    {
      'name': 'Dev',
      'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80',
      'badge': '',
    },
  ];

  // Mock Chat list data matching Screenshot 2 exactly
  final List<Map<String, dynamic>> _chats = [
    {
      'id': '1',
      'name': 'Aanya',
      'age': 25,
      'match': 92,
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80',
      'time': '2m',
      'unread': 2,
      'message': 'Can’t wait to see you tonight at the...',
      'progress': 1.0,
      'progressText': 'Gift unlocked!',
      'progressIcon': '🎁',
      'isTyping': false,
    },
    {
      'id': '2',
      'name': 'Jordan',
      'age': 27,
      'match': 88,
      'avatar': 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=400&q=80',
      'time': 'Now',
      'unread': 0,
      'message': 'Typing...',
      'progress': 0.72,
      'progressText': '18/25 for Premium Rose',
      'progressIcon': '🌹',
      'isTyping': true,
    },
    {
      'id': '3',
      'name': 'Marcus',
      'age': 29,
      'match': 75,
      'avatar': 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?auto=format&fit=crop&w=400&q=80',
      'time': '1h',
      'unread': 0,
      'message': 'That sounds like an amazing hobby! Ho...',
      'progress': 0.20,
      'progressText': '5/25 · Deadline 14h',
      'progressIcon': '⏰',
      'isTyping': false,
    },
    {
      'id': '4',
      'name': 'Elena',
      'age': 23,
      'match': 95,
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
      'time': '3h',
      'unread': 0,
      'message': 'You: Hey! I’m heading over now.',
      'progress': 0.88,
      'progressText': '22/25 for Silver Ring',
      'progressIcon': '💍',
      'isTyping': false,
    },
    {
      'id': '5',
      'name': 'Rohan',
      'age': 26,
      'match': 81,
      'avatar': 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=400&q=80',
      'time': 'Yesterday',
      'unread': 0,
      'message': 'Haha let’s meet tomorrow then.',
      'progress': 0.40,
      'progressText': '10/25 completed',
      'progressIcon': '✨',
      'isTyping': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final filteredChats = _chats.where((chat) {
      if (_searchQuery.isNotEmpty) {
        final name = chat['name'].toString().toLowerCase();
        final message = chat['message'].toString().toLowerCase();
        if (!name.contains(_searchQuery) && !message.contains(_searchQuery)) {
          return false;
        }
      }
      switch (_activeFilter) {
        case 'Unread':
          return (chat['unread'] as int) > 0;
        case 'Online':
          return chat['name'] == 'Aanya' || chat['name'] == 'Jordan' || chat['name'] == 'Elena';
        case 'Nearby':
          return (chat['match'] as int) > 85;
        case 'Dating Goals':
          return (chat['progress'] as double) >= 0.5;
        default:
          return true;
      }
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F5), // Premium warm off-white cream background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildNewMatchesSection(),
                  const SizedBox(height: 12),
                  _buildFiltersRow(),
                  const SizedBox(height: 12),
                  ...filteredChats.map((chat) => _buildChatTile(context, chat)),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Messages',
            style: AppTextStyles.headingMedium.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary, size: 24),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: Colors.black38, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim().toLowerCase();
                  });
                },
                style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Search matches or messages',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 13.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildNewMatchesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NEW MATCHES',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.black45,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 1.0,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'See all →',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 96,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _newMatches.length,
            itemBuilder: (context, index) {
              final match = _newMatches[index];
              return Container(
                margin: const EdgeInsets.only(right: 14),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(match['avatar']!),
                        ),
                        if (match['badge']!.isNotEmpty)
                          Positioned(
                            top: -2,
                            right: -2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: match['badge'] == 'NEW' ? AppColors.primary : const Color(0xFF263238),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: Text(
                                match['badge']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      match['name']!,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
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
          final isSelected = _activeFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => _activeFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
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

  Widget _buildChatTile(BuildContext context, Map<String, dynamic> chat) {
    // Generate a simple mock UserEntity for routing
    final user = UserEntity(
      id: chat['id'],
      firstName: chat['name'],
      lastName: '',
      age: chat['age'],
      city: 'Pune',
      state: 'Maharashtra',
      country: 'India',
      avatarThumb: chat['avatar'],
      avatarLarge: chat['avatar'],
      email: '',
      phone: '',
      gender: 'female',
      isOnline: true,
      isVerified: true,
      distance: 3.4,
      compatibility: chat['match'],
      interests: const ['Travel', 'Books'],
      bio: 'Let\'s connect and plan a date!',
    );

    return InkWell(
      onTap: () => context.push('/chat/${user.id}', extra: user),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.02), width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Avatar with Online Badge
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(chat['avatar']),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF66BB6A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),

            // Content details column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${chat['name']}, ${chat['age']}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Match Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCE4EC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${chat['match']}% Match',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Message body or Typing state
                  Text(
                    chat['message'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: chat['isTyping'] == true ? AppColors.primary : Colors.black45,
                      fontWeight: chat['unread'] > 0 || chat['isTyping'] == true ? FontWeight.w700 : FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Progress bar matching Screenshot 2
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(color: Colors.pink.shade50),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: chat['progress'],
                              child: Container(
                                color: chat['progress'] == 1.0 ? const Color(0xFF66BB6A) : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Progress Icons/Label text
                      Text(
                        chat['progressIcon']!,
                        style: const TextStyle(fontSize: 11),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        chat['progressText']!,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: chat['progress'] == 1.0 ? const Color(0xFF66BB6A) : Colors.black38,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // Time & Unread Badge Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat['time'],
                  style: AppTextStyles.labelSmall.copyWith(color: Colors.black38, fontSize: 11),
                ),
                const SizedBox(height: 6),
                if (chat['unread'] > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${chat['unread']}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
