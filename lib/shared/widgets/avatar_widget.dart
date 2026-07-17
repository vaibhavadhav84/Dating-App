// lib/shared/widgets/avatar_widget.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';
import 'online_badge.dart';

class AvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool isOnline;
  final bool hasBorder;
  final bool hasStoryRing;
  final String? heroTag;

  const AvatarWidget({
    super.key,
    required this.imageUrl,
    this.size = 52,
    this.isOnline = false,
    this.hasBorder = false,
    this.hasStoryRing = false,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: hasBorder
            ? Border.all(color: AppColors.primary, width: 2)
            : hasStoryRing
                ? null
                : Border.all(color: Colors.white, width: 2),
        gradient: hasStoryRing ? AppColors.storyRingGradient : null,
      ),
      child: Padding(
        padding: hasStoryRing ? const EdgeInsets.all(2.5) : EdgeInsets.zero,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: AppColors.shimmerBase,
              highlightColor: AppColors.shimmerHighlight,
              child: Container(
                color: AppColors.shimmerBase,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.secondary,
              child: const Icon(Icons.person, color: AppColors.primary),
            ),
          ),
        ),
      ),
    );

    final Widget content = heroTag != null
        ? Hero(tag: heroTag!, child: avatar)
        : avatar;

    if (isOnline) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          content,
          Positioned(
            right: 0,
            bottom: 0,
            child: OnlineBadge(size: size * 0.22),
          ),
        ],
      );
    }
    return content;
  }
}
