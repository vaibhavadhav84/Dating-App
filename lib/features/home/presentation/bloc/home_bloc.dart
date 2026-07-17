// lib/features/home/presentation/bloc/home_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_users_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersUsecase getUsersUsecase;
  final GetUsersPageUsecase getUsersPageUsecase;
  int _currentPage = 1;

  HomeBloc({
    required this.getUsersUsecase,
    required this.getUsersPageUsecase,
  }) : super(const HomeInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
    on<FilterChanged>(_onFilterChanged);
    on<SwipeUser>(_onSwipeUser);
    on<UndoSwipe>(_onUndoSwipe);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    _currentPage = 1;
    final (users, failure) = await getUsersUsecase.call(results: 20);
    if (failure != null) {
      emit(HomeError(message: failure.message));
    } else {
      emit(HomeLoaded(users: users ?? []));
    }
  }

  Future<void> _onRefreshUsers(
      RefreshUsers event, Emitter<HomeState> emit) async {
    _currentPage = 1;
    final (users, failure) = await getUsersUsecase.call(results: 20);
    if (failure != null) {
      emit(HomeError(message: failure.message));
    } else {
      emit(HomeLoaded(users: users ?? []));
    }
  }

  Future<void> _onLoadMoreUsers(
      LoadMoreUsers event, Emitter<HomeState> emit) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(HomeLoadingMore(users: currentState.users));
      _currentPage++;
      final (newUsers, failure) = await getUsersPageUsecase.call(
        page: _currentPage,
        results: 20,
      );
      if (failure != null) {
        emit(HomeLoaded(users: currentState.users));
      } else {
        emit(HomeLoaded(
          users: [...currentState.users, ...(newUsers ?? [])],
          currentIndex: currentState.currentIndex,
          activeFilter: currentState.activeFilter,
        ));
      }
    }
  }

  void _onFilterChanged(FilterChanged event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(activeFilter: event.filter));
    }
  }
  void _onSwipeUser(SwipeUser event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final newIndex = currentState.currentIndex + 1;
      if (newIndex >= currentState.users.length - 3) {
        add(const LoadMoreUsers());
      }
      emit(currentState.copyWith(currentIndex: newIndex));
    }
  }

  void _onUndoSwipe(UndoSwipe event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      if (currentState.currentIndex > 0) {
        emit(currentState.copyWith(currentIndex: currentState.currentIndex - 1));
      }
    }
  }
}
