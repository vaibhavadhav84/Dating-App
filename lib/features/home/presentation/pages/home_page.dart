// lib/features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../injection_container.dart';
import '../../../../shared/widgets/error_screen.dart';
import '../../../../shared/widgets/loading_skeleton.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
// import '../widgets/card_action_buttons.dart';
import '../widgets/profile_swipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _bloc;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _bloc = sl<HomeBloc>()..add(const LoadUsers());
  }

  @override
  void dispose() {
    _bloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    _bloc.add(const RefreshUsers());
    await Future.delayed(const Duration(milliseconds: 1200));
    _refreshController.refreshCompleted();
  }

  void _showMoreOptions(BuildContext context, dynamic user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.share_rounded, color: Colors.black87),
                title: Text('Share ${user.firstName}\'s profile', style: const TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile link copied to clipboard!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.block_rounded, color: Colors.black87),
                title: Text('Block ${user.firstName}', style: const TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  context.pop();
                  _bloc.add(SwipeUser(userId: user.id, isLiked: false));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You have blocked ${user.firstName}.')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag_rounded, color: Colors.redAccent),
                title: Text('Report ${user.firstName}', style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                onTap: () {
                  context.pop();
                  _bloc.add(SwipeUser(userId: user.id, isLiked: false));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile reported. Thank you for keeping our community safe!')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  header: ClassicHeader(
                    refreshingText: '',
                    completeText: '',
                    idleText: '',
                    releaseText: '',
                    refreshingIcon: const CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return switch (state) {
                        HomeInitial() || HomeLoading() => const Center(
                            child: HomeCardSkeleton(),
                          ),
                        HomeError(:final message) => ErrorScreen(
                            subtitle: message,
                            onRetry: () => _bloc.add(const LoadUsers()),
                          ),
                        HomeLoaded(:final users, :final currentIndex) =>
                          _buildCardStack(
                            context,
                            users: users,
                            currentIndex: currentIndex,
                            isLoadingMore: false,
                          ),
                        HomeLoadingMore(:final users) => _buildCardStack(
                            context,
                            users: users,
                            currentIndex: 0,
                            isLoadingMore: true,
                          ),
                      };
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // Hamburger menu
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.menu_rounded,
                color: AppColors.textPrimary, size: 26),
            onPressed: () {},
          ),
          const Spacer(),
          // Daily 25 pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Daily 25',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Lightning bolt icon
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.bolt_rounded,
                color: AppColors.textPrimary, size: 26),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
          // Filter/tune icon
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.tune_rounded,
                color: AppColors.textPrimary, size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
          // Notification bell with badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.notifications_outlined,
                    color: AppColors.textPrimary, size: 26),
                onPressed: () => context.push('/notifications'),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardStack(
    BuildContext context, {
    required List users,
    required int currentIndex,
    required bool isLoadingMore,
  }) {
    if (users.isEmpty || currentIndex >= users.length) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                color: AppColors.primary,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text('No more profiles!', style: AppTextStyles.headingSmall),
            const SizedBox(height: 8),
            Text(
              'Pull down to refresh',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // 3rd card (furthest back)
                if (currentIndex + 2 < users.length)
                  Transform.scale(
                    scale: 0.92,
                    child: ProfileSwipeCard(
                      key: ValueKey(users[currentIndex + 2].id + '_2'),
                      user: users[currentIndex + 2],
                      isTopCard: false,
                      stackOffset: -20,
                      onSwipeComplete: (_) {},
                      onTap: () {},
                    ),
                  ),
                // 2nd card (middle)
                if (currentIndex + 1 < users.length)
                  Transform.scale(
                    scale: 0.96,
                    child: ProfileSwipeCard(
                      key: ValueKey(users[currentIndex + 1].id + '_1'),
                      user: users[currentIndex + 1],
                      isTopCard: false,
                      stackOffset: -10,
                      onSwipeComplete: (_) {},
                      onTap: () {},
                    ),
                  ),
                // Top card (interactive)
                ProfileSwipeCard(
                  key: ValueKey(users[currentIndex].id),
                  user: users[currentIndex],
                  isTopCard: true,
                  onSwipeComplete: (isLiked) {
                    _bloc.add(SwipeUser(
                      userId: users[currentIndex].id,
                      isLiked: isLiked,
                    ));
                  },
                  onTap: () => context.push(
                    '/user/${users[currentIndex].id}',
                    extra: users[currentIndex],
                  ),
                  onUndoTap: () => _bloc.add(const UndoSwipe()),
                  onMoreTap: () => _showMoreOptions(context, users[currentIndex]),
                ),
              ],
            ),
          ),
        ),
        if (isLoadingMore)
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }
}
