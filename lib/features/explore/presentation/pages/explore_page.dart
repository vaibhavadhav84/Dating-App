// lib/features/explore/presentation/pages/explore_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/domain/entities/user_entity.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String _activeFilter = 'Today';

  final List<String> _filters = [
    'Today',
    'Tomorrow',
    'Weekend',
  ];

  // Mock Date Card options matching Screenshot 3
  final List<Map<String, dynamic>> _dateOptions = [
    {
      'id': '1',
      'title': 'Pasta & Honest Chats',
      'subtitle': 'Foodie looking for a dinner buddy 🍜',
      'venue': 'Olive Bar, Mahalaxmi',
      'distance': '3.4 km away',
      'time': '8:30 PM',
      'date': 'TODAY',
      'type': 'Dinner',
      'match': 88,
      'group': 'Just 1',
      'payment': 'I\'ll pay',
      'bgImage': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80&w=600',
      'userName': 'Ananya',
      'userAge': 25,
      'userAvatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80',
      'userBio': 'she/her · Foodie',
    },
    {
      'id': '2',
      'title': 'Coffee & Bookstore Stroll',
      'subtitle': 'Looking for a fellow book lover ☕📖',
      'venue': 'Blue Tokai, Koregaon Park',
      'distance': '1.2 km away',
      'time': '4:00 PM',
      'date': 'TOMORROW',
      'type': 'Coffee',
      'match': 94,
      'group': 'Just 1',
      'payment': 'Split bill',
      'bgImage': 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&q=80&w=600',
      'userName': 'Aanya',
      'userAge': 21,
      'userAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
      'userBio': 'she/her · Designer',    }
  ];

  int _currentIndex = 0;

  void _nextOption() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _dateOptions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentOption = _dateOptions[_currentIndex];

    // Build UserEntity for routing
    final user = UserEntity(
      id: currentOption['id'],
      firstName: currentOption['userName'],
      lastName: '',
      age: currentOption['userAge'],
      city: 'Pune',
      state: 'Maharashtra',
      country: 'India',
      avatarThumb: currentOption['userAvatar'],
      avatarLarge: currentOption['userAvatar'],
      email: '',
      phone: '',
      gender: 'female',
      isOnline: true,
      isVerified: true,
      distance: 3.4,
      compatibility: currentOption['match'],
      interests: const ['Foodie', 'Travel'],
      bio: 'Looking for a dinner buddy to try the new menu at Olive Bar.',
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F5), // Premium warm off-white cream background
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildFiltersRow(),
            const SizedBox(height: 12),
            
            // Date option card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(currentOption['bgImage']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Dark gradient overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.2),
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.8),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.0, 0.4, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Top left tags (Live and Distance)
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF66BB6A),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Live · ${currentOption['venue']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '📍 ${currentOption['distance']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Bottom content overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Translucent badges: Date, Time, Type
                              Row(
                                children: [
                                  _TranslucentBadge(
                                    icon: Icons.calendar_today_rounded,
                                    label: currentOption['date'],
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  _TranslucentBadge(
                                    icon: Icons.access_time_rounded,
                                    label: currentOption['time'],
                                  ),
                                  const SizedBox(width: 6),
                                  _TranslucentBadge(
                                    icon: Icons.people_outline_rounded,
                                    label: currentOption['type'],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Date Title & Subtitle
                              Text(
                                currentOption['title'],
                                style: AppTextStyles.cardName.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                currentOption['subtitle'],
                                style: AppTextStyles.cardLocation.copyWith(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Stats Row: Match%, size, payment
                              Row(
                                children: [
                                  _StatBadge(
                                    icon: Icons.favorite_rounded,
                                    label: '${currentOption['match']}% match',
                                  ),
                                  const SizedBox(width: 8),
                                  _StatBadge(
                                    icon: Icons.group_outlined,
                                    label: currentOption['group'],
                                  ),
                                  const SizedBox(width: 8),
                                  _StatBadge(
                                    icon: Icons.handshake_outlined,
                                    label: currentOption['payment'],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // User profile row card
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 0.5),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(currentOption['userAvatar']),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${currentOption['userName']}, ${currentOption['userAge']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 14),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            currentOption['userBio'],
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => context.push('/user/${user.id}', extra: user),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Row(
                                          children: [
                                            Text(
                                              'Profile',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Buttons (Skip & Request Date)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  // Skip button
                  Expanded(
                    child: InkWell(
                      onTap: _nextOption,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close_rounded, color: Colors.black54, size: 18),
                            SizedBox(width: 6),
                            Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Request Date button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Date requested successfully! 📅',
                              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                            ),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                        _nextOption();
                      },
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today_rounded, color: Colors.white, size: 16),
                            SizedBox(width: 8),
                            Text(
                              'Request Date',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
          Row(
            children: [
              Text(
                'Date ',
                style: AppTextStyles.headingMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Now',
                style: AppTextStyles.headingMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          // My Plans button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 12),
                const SizedBox(width: 6),
                const Text(
                  'My Plans',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
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
          final isSelected = _activeFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => _activeFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.black.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
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
}

class _TranslucentBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _TranslucentBadge({
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color ?? Colors.white, size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatBadge({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 11),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
