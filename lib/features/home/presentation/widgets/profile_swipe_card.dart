// lib/features/home/presentation/widgets/profile_swipe_card.dart
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/user_entity.dart';

class ProfileSwipeCard extends StatefulWidget {
  final UserEntity user;
  final bool isTopCard;
  final double stackOffset;
  final Function(bool isLiked) onSwipeComplete;
  final VoidCallback onTap;
  final VoidCallback? onUndoTap;
  final VoidCallback? onMoreTap;

  const ProfileSwipeCard({
    super.key,
    required this.user,
    required this.isTopCard,
    this.stackOffset = 0,
    required this.onSwipeComplete,
    required this.onTap,
    this.onUndoTap,
    this.onMoreTap,
  });  @override
  State<ProfileSwipeCard> createState() => _ProfileSwipeCardState();
}

class _ProfileSwipeCardState extends State<ProfileSwipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _snapController;
  late Animation<Offset> _snapAnimation;

  Offset _dragOffset = Offset.zero;

  static const double _swipeThreshold = 100.0;
  static const double _maxRotation = 15.0 * pi / 180;

  @override
  void initState() {
    super.initState();
    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _snapAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _snapController,
      curve: Curves.elasticOut,
    ));
    _snapController.addListener(() {
      setState(() {
        _dragOffset = _snapAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    if (!widget.isTopCard) return;
    _snapController.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.isTopCard) return;
    setState(() => _dragOffset += details.delta);
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.isTopCard) return;

    if (_dragOffset.dy < -80) {
      widget.onTap();
      _snapBack();
    } else if (_dragOffset.dx.abs() > _swipeThreshold) {
      final isLiked = _dragOffset.dx > 0;
      _animateOff(isLiked);
    } else {
      _snapBack();
    }
  }

  void _snapBack() {
    _snapAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _snapController,
      curve: Curves.elasticOut,
    ));
    _snapController.forward(from: 0);
  }

  void _animateOff(bool isLiked) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isLiked ? screenWidth * 1.5 : -screenWidth * 1.5;
    _snapAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset(targetX, _dragOffset.dy),
    ).animate(CurvedAnimation(
      parent: _snapController,
      curve: Curves.easeOut,
    ));
    _snapController.forward(from: 0).then((_) {
      widget.onSwipeComplete(isLiked);
    });
  }

  double get _rotationAngle {
    if (_dragOffset.dx == 0) return 0;
    return (_dragOffset.dx / (MediaQuery.of(context).size.width / 2)) *
        _maxRotation;
  }

  double get _likeOpacity => (_dragOffset.dx / _swipeThreshold).clamp(0, 1);
  double get _nopeOpacity => (-_dragOffset.dx / _swipeThreshold).clamp(0, 1);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.92;
    final cardHeight = size.height * 0.70;

    // Derived display data from user entity
    final matchPercent = widget.user.compatibility;
    final trustPercent = (70 + (matchPercent / 5).round()).clamp(0, 99);
    final replyTime = matchPercent > 80 ? '~5m' : matchPercent > 60 ? '~15m' : '~1h';
    final profession = widget.user.interests.isNotEmpty
        ? widget.user.interests.first
        : 'Professional';
    final height = "5'${4 + (matchPercent % 8)}\"";
    final relationship = matchPercent > 75 ? 'Serious relationship' : 'Something casual';

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      onTap: widget.isTopCard ? widget.onTap : null,
      child: Transform.translate(
        offset: _dragOffset + Offset(0, widget.stackOffset),
        child: Transform.rotate(
          angle: widget.isTopCard ? _rotationAngle : 0,
          child: RepaintBoundary(
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Card background photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Hero(
                      tag: 'user_${widget.user.id}',
                      child: CachedNetworkImage(
                        imageUrl: widget.user.avatarLarge,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.secondary,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.secondary,
                          child: const Icon(
                            Icons.person,
                            size: 80,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Dark gradient overlay at bottom
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.88),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.35, 0.65, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Top left — undo button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: widget.onUndoTap,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // Top right — more options
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: widget.onMoreTap,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.more_vert_rounded,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                  ),                  // Bottom content
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Match / Trust / Reply badges
                          Row(
                            children: [
                              _StatBadge(
                                dot: const Color(0xFF64B5F6),
                                label: '$matchPercent% Match',
                              ),
                              const SizedBox(width: 6),
                              _StatBadge(
                                dot: const Color(0xFF66BB6A),
                                label: '$trustPercent% Trust',
                              ),
                              const SizedBox(width: 6),
                              _StatBadge(
                                dot: const Color(0xFFFFCA28),
                                label: '$replyTime Reply',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Name + Age + Online dot + Verified
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (widget.user.isOnline)
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF66BB6A),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              Flexible(
                                child: Text(
                                  widget.user.firstName,
                                  style: AppTextStyles.cardName.copyWith(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${widget.user.age}',
                                style: AppTextStyles.cardAge.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (widget.user.isVerified) ...[
                                const SizedBox(width: 8),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Location
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: Colors.white70,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '${widget.user.shortLocation} · ${widget.user.distance.round()} km away',
                                  style: AppTextStyles.cardLocation,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Profession + Height
                          Row(
                            children: [
                              const Icon(
                                Icons.work_outline_rounded,
                                color: Colors.white70,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '$profession · $height',
                                  style: AppTextStyles.cardLocation,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Relationship type
                          Row(
                            children: [
                              const Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.white70,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                relationship,
                                style: AppTextStyles.cardLocation,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Rose button — bottom right
                  Positioned(
                    bottom: 20,
                    right: 16,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '🌹',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),

                  // LIKE badge overlay
                  if (widget.isTopCard && _likeOpacity > 0)
                    Positioned(
                      top: 40,
                      left: 20,
                      child: Opacity(
                        opacity: _likeOpacity,
                        child: Transform.rotate(
                          angle: -0.3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.success, width: 3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'LIKE',
                              style: AppTextStyles.headingMedium.copyWith(
                                color: AppColors.success,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // NOPE badge overlay
                  if (widget.isTopCard && _nopeOpacity > 0)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Opacity(
                        opacity: _nopeOpacity,
                        child: Transform.rotate(
                          angle: 0.3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.error, width: 3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'NOPE',
                              style: AppTextStyles.headingMedium.copyWith(
                                color: AppColors.error,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Card border
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Small frosted pill badge: dot + label
class _StatBadge extends StatelessWidget {
  final Color dot;
  final String label;

  const _StatBadge({required this.dot, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 0.5),
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
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
