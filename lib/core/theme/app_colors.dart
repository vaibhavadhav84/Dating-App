// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF4D8D);
  static const Color primaryLight = Color(0xFFFF6B9D);
  static const Color secondary = Color(0xFFFCE4EC);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F8F8);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF777777);
  static const Color textHint = Color(0xFFAAAAAA);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);

  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFF0F0F0);
  static const Color shimmerBase = Color(0xFFF0F0F0);
  static const Color shimmerHighlight = Color(0xFFFAFAFA);

  static const Color unreadBg = Color(0xFFFFF0F5);
  static const Color navBarBorder = Color(0xFFF0F0F0);
  static const Color greyIcon = Color(0xFFBBBBBB);
  static const Color filterChipBg = Color(0xFFF5F5F5);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardOverlayGradient = LinearGradient(
    colors: [Colors.transparent, Color(0xCC000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient storyRingGradient = LinearGradient(
    colors: [primary, primaryLight, Color(0xFFFF8C69)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxShadow get pinkShadow => BoxShadow(
        color: primary.withOpacity(0.15),
        blurRadius: 24,
        offset: const Offset(0, 8),
      );

  static BoxShadow get cardShadow => BoxShadow(
        color: Colors.black.withOpacity(0.12),
        blurRadius: 32,
        offset: const Offset(0, 12),
      );

  static BoxShadow get navShadow => BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 16,
        offset: const Offset(0, -4),
      );
}
