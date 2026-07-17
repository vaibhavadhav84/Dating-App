// lib/features/home/presentation/widgets/card_action_buttons.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CardActionButtons extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onLike;
  final VoidCallback onSuperLike;

  const CardActionButtons({
    super.key,
    required this.onSkip,
    required this.onLike,
    required this.onSuperLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Skip button
        _ActionButton(
          onTap: onSkip,
          icon: Icons.close_rounded,
          size: 52,
          color: Colors.white,
          iconColor: const Color(0xFF888888),
          elevation: 6,
        ),
        const SizedBox(width: 20),
        // Super like
        _ActionButton(
          onTap: onSuperLike,
          icon: Icons.star_rounded,
          size: 44,
          color: const Color(0xFF4FC3F7),
          iconColor: Colors.white,
          elevation: 6,
        ),
        const SizedBox(width: 20),
        // Like button — main CTA
        _GradientActionButton(
          onTap: onLike,
          icon: Icons.favorite_rounded,
          size: 64,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double size;
  final Color color;
  final Color iconColor;
  final double elevation;

  const _ActionButton({
    required this.onTap,
    required this.icon,
    required this.size,
    required this.color,
    required this.iconColor,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: size * 0.46),
      ),
    );
  }
}

class _GradientActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double size;

  const _GradientActionButton({
    required this.onTap,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.46),
      ),
    );
  }
}
