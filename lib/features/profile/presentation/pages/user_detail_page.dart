// lib/features/profile/presentation/pages/user_detail_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/secondary_button.dart';
import '../../../home/domain/entities/user_entity.dart';
import '../widgets/profile_image_header.dart';
import '../../../compliment/presentation/pages/compliment_page.dart';

class UserDetailPage extends StatefulWidget {
  final UserEntity user;

  const UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final ScrollController _scrollController = ScrollController();
  double _dragDistance = 0.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showComplimentModal(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ComplimentPage(title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    // Derived values for realistic feel
    final matchPercent = user.compatibility;
    final trustPercent = (70 + (matchPercent / 5).round()).clamp(0, 99);
    final replyTime = matchPercent > 80
        ? '~5m'
        : matchPercent > 60
            ? '~15m'
            : '~1h';

    // Calculate a mock birth date based on age
    final birthYear = DateTime.now().year - user.age;
    final birthDate = "19 feb $birthYear";

    final height =
        "5'${4 + (matchPercent % 6)}\" (${160 + (matchPercent % 15)} cm)";

    // Love languages mapping
    final loveLanguages = [
      ("Compliment", "Words of affirmation"),
      ("Quality Time", "Undivided attention"),
      ("Physical Touch", "Closeness and holding hands"),
      ("Acts of Service", "Thoughtful actions"),
      ("Receiving Gifts", "Visual symbols of love"),
    ];
    final loveLanguage = loveLanguages[matchPercent % loveLanguages.length];

    // Zodiacs mapping
    final zodiacs = [
      ("Scorpio", "Loyal - Passionate - Intuitive"),
      ("Leo", "Proud - Generous - Warm-hearted"),
      ("Taurus", "Patient - Reliable - Warmhearted"),
      ("Libra", "Diplomatic - Gracious - Social"),
      ("Gemini", "Gentle - Affectionate - Curious"),
    ];
    final zodiac = zodiacs[matchPercent % zodiacs.length];

    // Religion & Languages
    final religions = [
      "Hindu-Marathi",
      "Christian",
      "Buddhist",
      "Sikh",
      "Spiritual"
    ];
    final religion = religions[matchPercent % religions.length];

    final languages = ["Marathi", "English", "Hindi", "Spanish", "French"];
    final motherTongue = languages[matchPercent % languages.length];

    final commStyles = [
      "Phone calls over texts",
      "In person meetups",
      "Voice notes daily",
      "Frequent texting"
    ];
    final commStyle = commStyles[matchPercent % commStyles.length];

    // Career & Ambition details mapping
    final educationInstitutes = [
      ("NIFT Pune", "B. Des Fashion Design · 3rd year"),
      ("IIT Bombay", "B.Tech Computer Science · Alumnus"),
      ("Symbiosis Pune", "BBA Marketing · Final Year"),
      ("St. Xavier's Mumbai", "BA Literature · Alumnus"),
    ];
    final education =
        educationInstitutes[matchPercent % educationInstitutes.length];

    final professions = [
      ("Fashion Design", "Freelance · 2 yrs exp"),
      ("Software Engineer", "Tech Startup · 3 yrs exp"),
      ("Product Designer", "Design Agency · 1 yr exp"),
      ("Marketing Manager", "E-commerce · 4 yrs exp"),
    ];
    final profession = professions[matchPercent % professions.length];

    // Prompts mapping
    final prompt1 = (
      "The way to win me over is...",
      "A good book rec and a strong chai opinion."
    );
    final prompt2 = (
      "My simple pleasures...",
      "Roadside chai after a long trek, no signal, good company."
    );
    final prompt3 = (
      "We'll get along if...",
      "You can debate me for an hour and still want dessert after."
    );

    // Big dreams mapping
    final bigDreams = [
      "Launch her own sustainable Indian fashion label — handcrafted, slow fashion made with heart. Also wants to travel every fashion capital before 30.",
      "Build a tech non-profit to bring coding resources to rural children. Also wants to witness the Northern Lights from a glass igloo.",
      "Start a farm-to-table boutique café that hosts weekly indie music gigs and book readings. Also hopes to publish a novel someday.",
      "Run a design studio that works solely on environmental sustainability and social impact. Also hopes to skydive over the Swiss Alps.",
    ];
    final bigDream = bigDreams[matchPercent % bigDreams.length];

    // Lifestyle details
    final diets = ["Vegetarian", "Vegan", "Non-Vegetarian", "Eggetarian"];
    final diet = diets[matchPercent % diets.length];

    final drinkings = ["Socially", "Never", "Regularly", "Occasionally"];
    final drinking = drinkings[matchPercent % drinkings.length];

    final sleeps = [
      "Night Owl",
      "Early Bird",
      "Routine sleeper",
      "Flexible sleeper"
    ];
    final sleep = sleeps[matchPercent % sleeps.length];

    // Dating Goal
    final datingGoals = [
      "Long-term, marriage-open",
      "Short-term relationship",
      "Casual dating",
      "New friends only",
    ];
    final datingGoal = datingGoals[matchPercent % datingGoals.length];

    final datingGoalDesc = [
      "No pressure, no timelines — just looking for the right person to build something real with.",
      "Enjoying the present moment and seeing where things go naturally.",
      "Fun vibes, great conversations, and exciting adventures without deep expectations.",
      "Exploring shared interests, discovering new places, and making meaningful friendships.",
    ];
    final datingGoalDescription =
        datingGoalDesc[matchPercent % datingGoalDesc.length];

    // Interest chips
    final allInterestChips = [
      (Icons.flight_takeoff_rounded, 'Travel'),
      (Icons.coffee_rounded, 'Coffee'),
      (Icons.terrain_rounded, 'Trekking'),
      (Icons.menu_book_rounded, 'Books'),
      (Icons.accessibility_new_rounded, 'Yoga'),
      (Icons.music_note_rounded, 'Indie music'),
      (Icons.restaurant_menu_rounded, 'Cooking'),
      (Icons.camera_alt_outlined, 'Photography'),
    ];

    return Scaffold(
      backgroundColor:
          const Color(0xFFF9F7F5), // Premium warm off-white cream background
      body: Stack(
        children: [
          GestureDetector(
            onVerticalDragUpdate: (details) {
              if (_scrollController.hasClients &&
                  _scrollController.offset <= 0 &&
                  details.primaryDelta! > 0) {
                _dragDistance += details.primaryDelta!;
              } else {
                _dragDistance = 0.0;
              }
            },
            onVerticalDragEnd: (details) {
              if (_dragDistance > 80) {
                context.pop();
              }
              _dragDistance = 0.0;
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
              SliverToBoxAdapter(
                child: ProfileImageHeader(
                  imageUrl: user.avatarLarge,
                  heroTag: 'user_${user.id}',
                  onBack: () => context.pop(),
                  onShare: () {},
                  onMore: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Match Badges (Match, Trust, Replies)
                      Row(
                        children: [
                          _StatBadge(
                            dot: const Color(0xFF64B5F6),
                            label: '$matchPercent% Match',
                          ),
                          const SizedBox(width: 8),
                          _StatBadge(
                            dot: const Color(0xFF66BB6A),
                            label: '$trustPercent% Trust',
                          ),
                          const SizedBox(width: 8),
                          _StatBadge(
                            dot: const Color(0xFFFFCA28),
                            label: '$replyTime Replies',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ABOUT heading
                      Text(
                        'ABOUT',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Bio text with a small floating rose decoration
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 48),
                            child: Text(
                              user.bio,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                                height: 1.5,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () => _showComplimentModal(context, 'About'),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFCE4EC),
                                  shape: BoxShape.circle,
                                ),
                                child: const Text('🌹',
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // THE BASICS heading
                      Text(
                        'THE BASICS',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // White rounded card for basics
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _BasicRow(
                              icon: Icons.cake_outlined,
                              label: 'Age',
                              value: '${user.age} years old',
                              subtext: birthDate,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.rule_outlined,
                              label: 'Height',
                              value: height,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.home_work_outlined,
                              label: 'Lives in',
                              value: user.city,
                              subtext: '${user.city}, ${user.country}',
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.favorite_border_rounded,
                              label: 'Love language',
                              value: loveLanguage.$1,
                              subtext: loveLanguage.$2,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.brightness_3_outlined,
                              label: 'Religion',
                              value: religion,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.people_outline_rounded,
                              label: 'Interested in',
                              value: user.gender == 'female'
                                  ? 'Men - Dating'
                                  : 'Women - Dating',
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.wb_sunny_outlined,
                              label: 'Zodiac',
                              value: zodiac.$1,
                              subtext: zodiac.$2,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.translate_rounded,
                              label: 'Mother tongue',
                              value: motherTongue,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.phone_android_rounded,
                              label: 'Communication style',
                              value: commStyle,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Floating rose icon
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => _showComplimentModal(context, 'About'),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCE4EC),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('🌹',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Prompt card 1: "The way to win me over is..."
                      _PromptCard(
                        promptTitle: prompt1.$1,
                        promptContent: prompt1.$2,
                        onRoseTap: () => _showComplimentModal(context, 'Prompt'),
                      ),
                      const SizedBox(height: 30),

                      // CAREER & AMBITION heading
                      Text(
                        'CAREER & AMBITION',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // White rounded card for Career & Ambition
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _BasicRow(
                              icon: Icons.school_outlined,
                              label: 'Education',
                              value: education.$1,
                              subtext: education.$2,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.work_outline_rounded,
                              label: 'Work as',
                              value: profession.$1,
                              subtext: profession.$2,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.auto_awesome_outlined,
                              label: 'Work style',
                              value: 'Creative · Hybrid',
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.trending_up_rounded,
                              label: 'Ambition level',
                              value: 'HIGHLY DRIVEN',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // HER BIG DREAM heading
                      Text(
                        'HER BIG DREAM',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Big dream paragraph text
                      Text(
                        bigDream,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Floating rose icon
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => _showComplimentModal(context, 'About'),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCE4EC),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('🌹',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Prompt card 2: "My simple pleasures..."
                      _PromptCard(
                        promptTitle: prompt2.$1,
                        promptContent: prompt2.$2,
                        onRoseTap: () => _showComplimentModal(context, 'Prompt'),
                      ),
                      const SizedBox(height: 24),

                      // INTERESTS & HOBBIES heading
                      Text(
                        'INTERESTS & HOBBIES',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Wrap of custom icon chips with white backgrounds
                      Wrap(
                        spacing: 8,
                        runSpacing: 10,
                        children: allInterestChips.map((chip) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                  color: Colors.black.withValues(alpha: 0.05)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(chip.$1,
                                    color: AppColors.primary
                                        .withValues(alpha: 0.7),
                                    size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  chip.$2,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Floating rose icon
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => _showComplimentModal(context, 'About'),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCE4EC),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('🌹',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // LIFESTYLE heading
                      Text(
                        'LIFESTYLE',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // White rounded card for Lifestyle details
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _BasicRow(
                              icon: Icons.restaurant_menu_rounded,
                              label: 'Diet',
                              value: diet,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.local_bar_rounded,
                              label: 'Drinking',
                              value: drinking,
                            ),
                            _Divider(),
                            _BasicRow(
                              icon: Icons.nights_stay_outlined,
                              label: 'Sleep',
                              value: sleep,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Floating rose icon
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => _showComplimentModal(context, 'About'),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCE4EC),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('🌹',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // DATING GOAL Card (solid pink card background with white text)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DATING GOAL',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              datingGoal,
                              style: AppTextStyles.headingSmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              datingGoalDescription,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 13.5,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Secondary Photo Card of User (full width, rounded corners)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          user.avatarLarge,
                          width: double.infinity,
                          height: 350,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Floating rose icon
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => _showComplimentModal(context, 'About'),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCE4EC),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('🌹',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Prompt card 3: "We'll get along if..."
                      _PromptCard(
                        promptTitle: prompt3.$1,
                        promptContent: prompt3.$2,
                        onRoseTap: () => _showComplimentModal(context, 'Prompt'),
                      ),
                      const SizedBox(height: 24),

                      // Video Intro card
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(user.avatarThumb),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Glassmorphic dark overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withValues(alpha: 0.1),
                                      Colors.black.withValues(alpha: 0.5),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            // Play Button in center
                            Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                              ),
                            ),
                            // Video intro label
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Text(
                                'Video intro · 0:28',
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Extra spacing for sticky bar
                      const SizedBox(height: 110),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ),

          // Sticky bottom action bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      label: 'Message',
                      icon: const Icon(Icons.chat_bubble_outline_rounded,
                          color: AppColors.primary, size: 18),
                      onPressed: () => context.push('/chat/${user.id}', extra: user),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Like Profile',
                      icon: const Icon(Icons.favorite_rounded,
                          color: Colors.white, size: 18),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small frosted pill badge for profile details
class _StatBadge extends StatelessWidget {
  final Color dot;
  final String label;

  const _StatBadge({required this.dot, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: Colors.black.withValues(alpha: 0.06), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// A line in the Basics/Career sections
class _BasicRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subtext;

  const _BasicRow({
    required this.icon,
    required this.label,
    required this.value,
    this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon,
              color: AppColors.primary.withValues(alpha: 0.75), size: 22),
          const SizedBox(width: 14),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              if (subtext != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtext!,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textHint,
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Clean Prompt Card styling matching the screenshots
class _PromptCard extends StatelessWidget {
  final String promptTitle;
  final String promptContent;
  final VoidCallback onRoseTap;

  const _PromptCard({
    required this.promptTitle,
    required this.promptContent,
    required this.onRoseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                promptTitle,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                promptContent,
                style: AppTextStyles.headingSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
          Positioned(
            left: -4,
            bottom: -40,
            child: GestureDetector(
              onTap: onRoseTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F7F5),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Text('🌹', style: TextStyle(fontSize: 12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF2F0ED),
    );
  }
}
