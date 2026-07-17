// lib/features/profile/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../home/domain/entities/user_entity.dart';
import '../widgets/info_section.dart';
import '../widgets/lifestyle_grid.dart';
import '../../../home/presentation/widgets/interest_chip.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Mocked current user
  static final UserEntity _currentUser = UserEntity(
    id: 'current-user',
    firstName: 'Emma',
    lastName: 'Collins',
    age: 26,
    city: 'San Francisco',
    state: 'California',
    country: 'United States',

    avatarThumb: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
    avatarLarge: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=800&q=80',
    email: 'emma.collins@email.com',
    phone: '+1 555 0144',
    gender: 'female',
    isOnline: true,
    isVerified: true,
    distance: 0,
    compatibility: 100,
    interests: ['Travel', 'Music', 'Fitness'],
    bio:
        'Hey! I\'m Emma — adventurer, foodie & sunset chaser 🌅. Looking for someone to explore the world with!',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.45,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    _currentUser.avatarLarge,
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: Text('My Profile', style: AppTextStyles.headingSmall),
            actions: [
              IconButton(
                icon:
                    const Icon(Icons.edit_rounded, color: AppColors.primary),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings_rounded,
                    color: AppColors.primary),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                InfoSection(user: _currentUser),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Interests', style: AppTextStyles.sectionHeader),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _currentUser.interests
                            .map((i) =>
                                InterestChip(label: i, isLight: false))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                LifestyleGrid(user: _currentUser),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                    label: 'Edit Profile',
                    icon: const Icon(Icons.edit_rounded,
                        color: Colors.white, size: 18),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
