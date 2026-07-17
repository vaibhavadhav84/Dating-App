// lib/features/explore/presentation/bloc/explore_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/usecases/get_users_usecase.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetUsersUsecase getUsersUsecase;

  ExploreBloc({required this.getUsersUsecase}) : super(const ExploreInitial()) {
    on<LoadExplore>(_onLoad);
    on<RefreshExplore>(_onRefresh);
    on<SearchChanged>(_onSearch);
    on<ExploreFilterChanged>(_onFilterChanged);
  }

  Future<void> _onLoad(LoadExplore event, Emitter<ExploreState> emit) async {
    emit(const ExploreLoading());
    final (users, failure) = await getUsersUsecase.call(results: 30);
    if (failure != null) {
      emit(ExploreError(message: failure.message));
    } else {
      final all = users ?? [];
      final sorted = List.of(all)
        ..sort((a, b) => a.distance.compareTo(b.distance));
      emit(ExploreLoaded(
        users: all,
        nearbyUsers: sorted.take(8).toList(),
        trendingUsers: all.take(10).toList(),
      ));
    }
  }

  Future<void> _onRefresh(
      RefreshExplore event, Emitter<ExploreState> emit) async {
    add(const LoadExplore());
  }

  void _onSearch(SearchChanged event, Emitter<ExploreState> emit) {
    final current = state;
    if (current is ExploreLoaded) {
      emit(current.copyWith(searchQuery: event.query));
    }
  }

  void _onFilterChanged(
      ExploreFilterChanged event, Emitter<ExploreState> emit) {
    final current = state;
    if (current is ExploreLoaded) {
      emit(current.copyWith(activeFilter: event.filter));
    }
  }
}
