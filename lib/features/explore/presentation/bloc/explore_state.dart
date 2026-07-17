// lib/features/explore/presentation/bloc/explore_state.dart
import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/user_entity.dart';

sealed class ExploreState extends Equatable {
  const ExploreState();
  @override
  List<Object?> get props => [];
}

class ExploreInitial extends ExploreState {
  const ExploreInitial();
}

class ExploreLoading extends ExploreState {
  const ExploreLoading();
}

class ExploreLoaded extends ExploreState {
  final List<UserEntity> users;
  final List<UserEntity> nearbyUsers;
  final List<UserEntity> trendingUsers;
  final String activeFilter;
  final String searchQuery;

  const ExploreLoaded({
    required this.users,
    required this.nearbyUsers,
    required this.trendingUsers,
    this.activeFilter = 'All',
    this.searchQuery = '',
  });

  List<UserEntity> get filteredUsers {
    var result = users;
    if (searchQuery.isNotEmpty) {
      result = result
          .where((u) =>
              u.fullName.toLowerCase().contains(searchQuery.toLowerCase()) ||
              u.city.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    switch (activeFilter) {
      case 'Online':
        return result.where((u) => u.isOnline).toList();
      case 'Verified':
        return result.where((u) => u.isVerified).toList();
      case 'Nearby':
        return result..sort((a, b) => a.distance.compareTo(b.distance));
      default:
        return result;
    }
  }

  ExploreLoaded copyWith({
    List<UserEntity>? users,
    List<UserEntity>? nearbyUsers,
    List<UserEntity>? trendingUsers,
    String? activeFilter,
    String? searchQuery,
  }) =>
      ExploreLoaded(
        users: users ?? this.users,
        nearbyUsers: nearbyUsers ?? this.nearbyUsers,
        trendingUsers: trendingUsers ?? this.trendingUsers,
        activeFilter: activeFilter ?? this.activeFilter,
        searchQuery: searchQuery ?? this.searchQuery,
      );

  @override
  List<Object?> get props =>
      [users, nearbyUsers, trendingUsers, activeFilter, searchQuery];
}

class ExploreError extends ExploreState {
  final String message;
  const ExploreError({required this.message});
  @override
  List<Object?> get props => [message];
}
