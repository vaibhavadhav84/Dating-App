// lib/features/home/presentation/bloc/home_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<UserEntity> users;
  final int currentIndex;
  final String activeFilter;

  const HomeLoaded({
    required this.users,
    this.currentIndex = 0,
    this.activeFilter = 'All',
  });

  HomeLoaded copyWith({
    List<UserEntity>? users,
    int? currentIndex,
    String? activeFilter,
  }) {
    return HomeLoaded(
      users: users ?? this.users,
      currentIndex: currentIndex ?? this.currentIndex,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }

  @override
  List<Object?> get props => [users, currentIndex, activeFilter];
}

class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class HomeLoadingMore extends HomeState {
  final List<UserEntity> users;
  const HomeLoadingMore({required this.users});

  @override
  List<Object?> get props => [users];
}
