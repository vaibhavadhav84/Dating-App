// lib/features/compliment/presentation/pages/compliment_page.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
class ComplimentPage extends StatefulWidget {
  final String title;
  const ComplimentPage({super.key, this.title = 'About'});

  @override
  State<ComplimentPage> createState() => _ComplimentPageState();
}

class _ComplimentPageState extends State<ComplimentPage> {
  // Navigation states: true = show Compliment Ideas screen, false = show main Complimenting Prompt screen
  bool _showIdeasScreen = false;

  final TextEditingController _controller = TextEditingController();
  int _charCount = 0;

  // Selected idea tab
  String _activeTab = 'Sweet';

  // Compliment ideas categories
  static const Map<String, List<String>> _ideasCategories = {
    'Sweet': [
      'Your smile is absolutely contagious 😊',
      'You have the kind of warmth that makes people feel at home.',
      'There’s something genuinely lovely about your energy.',
      'I could probably talk to you for hours and never get bored.',
      'You seem like the kind of person who makes ordinary days better.',
      'Your kindness really comes through in your profile.',
    ],
    'Playful': [
      'Are you a magician? Because whenever I look at your photos, everyone else disappears! ✨',
      'Do you believe in love at first swipe, or should I swipe left and right again? 😉',
      'Let’s skip the small talk, what’s your favorite roadside chai spot?',
      'If you were a dessert, you’d definitely be sizzling brownie with ice cream! 🍨',
    ],
    'Admiring': [
      'I really admire your creative ambition and drive.',
      'The sustainable fashion label dream is so inspiring! 🌿',
      'You have a wonderful sense of style and presentation.',
      'Your adventurous travel stories look absolutely amazing.',
    ],
    'Flirty': [
      'Is it hot in here or is it just your profile? 🔥',
      'I was having a boring day, but then I saw your smile.',
      'You look like trouble... the fun kind!',
      'Let’s make a plan to grab a coffee and see if we match in real life too.',
    ],
    'Funny': [
      'My parents told me to follow my dreams, so I’m following you! 😂',
      'Please tell me you’re as funny in person as your prompts are.',
      'I’m not a photographer, but I can definitely picture us together.',
      'My chai opinions are controversial, swipe with caution!',
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _charCount = _controller.text.length;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sheetHeight = _showIdeasScreen
        ? MediaQuery.of(context).size.height * 0.85
        : MediaQuery.of(context).size.height * 0.50;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      height: sheetHeight,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F7F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _showIdeasScreen ? _buildIdeasScreen() : _buildMainScreen(),
        ),
      ),
    );
  }

  // --- SCREEN 1: COMPLIMENTING PROMPT SHEET ---
  Widget _buildMainScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4.5,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),


          // Header Label
          Text(
            'COMPLIMENTING',
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.black45,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.title,
            style: AppTextStyles.headingMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),

          // Statistics Row
          Row(
            children: [
              _StatPill(
                  icon: Icons.chat_bubble_outline_rounded, text: '3 comments'),
              const SizedBox(width: 8),
              _StatPill(icon: Icons.favorite_border_rounded, text: '2 roses'),
              const SizedBox(width: 8),
              _StatPill(
                  icon: Icons.monetization_on_outlined, text: '5,258 balance'),
            ],
          ),
          const SizedBox(height: 18),

          // Compliment Input Field Card
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.black.withValues(alpha: 0.05)),
                    ),
                    child: Stack(
                      children: [
                        TextField(
                          controller: _controller,
                          maxLines: 4,
                          maxLength: 140,
                          style:
                              AppTextStyles.bodyMedium.copyWith(fontSize: 15),
                          decoration: const InputDecoration(
                            hintText: 'Write a sweet compliment...',
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                        // "Try" Button
                        Positioned(
                          right: 4,
                          bottom: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showIdeasScreen = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color:
                                        Colors.black.withValues(alpha: 0.08)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('💡',
                                      style: TextStyle(fontSize: 12)),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Try',
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
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
                  const SizedBox(height: 10),
                  // Limit counter
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$_charCount/140',
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textHint),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Selection Row: Rose (checked) & Select Gift
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    AppColors.primary.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('🌹', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 8),
                              Text(
                                'Rose',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.check_circle_rounded,
                                  color: AppColors.primary, size: 16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.black.withValues(alpha: 0.05)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('🎁', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 8),
                              Text(
                                'Select Gift',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Row (Like + Send Compliment)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              children: [
                // Heart Like Icon Button
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.15)),
                  ),
                  child: const Center(
                    child: Icon(Icons.favorite_rounded,
                        color: AppColors.primary, size: 24),
                  ),
                ),
                const SizedBox(width: 12),
                // Send Compliment Button
                Expanded(
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Compliment sent successfully! 🌹',
                              style: AppTextStyles.bodyMedium
                                  .copyWith(color: Colors.white),
                            ),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Send Compliment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
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

  // --- SCREEN 2: COMPLIMENT IDEAS SCREEN ---
  Widget _buildIdeasScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // Header Row with back button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.textPrimary, size: 20),
                onPressed: () {
                  setState(() {
                    _showIdeasScreen = false;
                  });
                },
              ),
              const Spacer(),
              const Text('💬', style: TextStyle(fontSize: 20)),
              const Spacer(),
              const SizedBox(width: 40), // spacer offset back button
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Title and description
        Center(
          child: Column(
            children: [
              Text(
                'Compliment Ideas',
                style: AppTextStyles.headingMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'pick one to make a great first impression',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Horizontally scrolling categories tab bar
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: _ideasCategories.keys.map((tab) {
              final isSelected = _activeTab == tab;
              return GestureDetector(
                onTap: () => setState(() => _activeTab = tab),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.black.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tab,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color:
                            isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 18),

        // Suggestions List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: _ideasCategories[_activeTab]!.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final ideaText = _ideasCategories[_activeTab]![index];
              return GestureDetector(
                onTap: () {
                  _controller.text = ideaText;
                  setState(() {
                    _showIdeasScreen = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    ideaText,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.4,
                      fontSize: 14.5,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Helper pill showing details inside sheet
class _StatPill extends StatelessWidget {
  final IconData icon;
  final String text;

  const _StatPill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary.withValues(alpha: 0.7), size: 14),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
