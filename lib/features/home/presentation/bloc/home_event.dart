// lib/features/home/presentation/bloc/home_event.dart
import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}
class LoadUsers extends HomeEvent {
  const LoadUsers();
}

class UndoSwipe extends HomeEvent {
  const UndoSwipe();
}
class RefreshUsers extends HomeEvent {
  const RefreshUsers();
}

class LoadMoreUsers extends HomeEvent {
  const LoadMoreUsers();
}

class FilterChanged extends HomeEvent {
  final String filter;
  const FilterChanged({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class SwipeUser extends HomeEvent {
  final String userId;
  final bool isLiked;
  const SwipeUser({required this.userId, required this.isLiked});

  @override
  List<Object?> get props => [userId, isLiked];
}
