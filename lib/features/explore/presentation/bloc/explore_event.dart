// lib/features/explore/presentation/bloc/explore_event.dart
import 'package:equatable/equatable.dart';

sealed class ExploreEvent extends Equatable {
  const ExploreEvent();
  @override
  List<Object?> get props => [];
}

class LoadExplore extends ExploreEvent {
  const LoadExplore();
}

class RefreshExplore extends ExploreEvent {
  const RefreshExplore();
}

class SearchChanged extends ExploreEvent {
  final String query;
  const SearchChanged({required this.query});
  @override
  List<Object?> get props => [query];
}

class ExploreFilterChanged extends ExploreEvent {
  final String filter;
  const ExploreFilterChanged({required this.filter});
  @override
  List<Object?> get props => [filter];
}
