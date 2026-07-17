// lib/core/constants/app_constants.dart

class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'https://randomuser.me/api';
  static const int pageSize = 20;
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Interests list
  static const List<String> interestsList = [
    'Travel',
    'Music',
    'Fitness',
    'Cooking',
    'Reading',
    'Gaming',
    'Photography',
    'Art',
    'Movies',
    'Hiking',
    'Dancing',
    'Yoga',
    'Coffee',
    'Wine',
    'Pets',
    'Beach',
    'Mountains',
    'Tech',
    'Fashion',
    'Food',
  ];

  // Bio templates
  static const List<String> bioTemplates = [
    'Hey, I\'m {name}! I love exploring new places and meeting interesting people. Let\'s grab coffee! ☕',
    'Life is short, let\'s make it count. {name} here — adventurer, foodie & sunset chaser 🌅',
    '{name} | Professional daydreamer & amateur chef. Looking for my partner in crime 😄',
    'Just a {name} living her best life 🌸 Swipe right if you love adventures!',
    'Hi! I\'m {name}. Passionate about travel, music, and finding the best brunch spots in town 🍳',
    '{name} — coffee addict, bookworm, and serial brunch-goer. Dog lover 🐶',
    'They say life is better with good company. I\'m {name}, and I couldn\'t agree more 🌟',
    '{name} here! I believe in long walks, great conversations, and even better pizza 🍕',
  ];

  // Date planning categories
  static const List<String> dateCategories = [
    'Restaurants',
    'Activities',
    'Coffee',
    'Movies',
  ];
}
