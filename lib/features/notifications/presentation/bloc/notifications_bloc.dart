// lib/features/notifications/presentation/bloc/notifications_bloc.dart
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/usecases/get_users_usecase.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc
    extends Bloc<NotificationsEvent, NotificationsState> {
  final GetUsersUsecase getUsersUsecase;

  NotificationsBloc({required this.getUsersUsecase})
      : super(const NotificationsInitial()) {
    on<LoadNotifications>(_onLoad);
    on<MarkAsRead>(_onMarkRead);
  }

  static const _titles = {
    NotifType.like: ['liked your profile!', 'sent you a like! 💕'],
    NotifType.message: ['sent you a message', 'wants to chat 💬'],
    NotifType.match: ['It\'s a match! 🎉', 'You matched with'],
    NotifType.superLike: ['super liked you! ⭐', 'gave you a super like!'],
  };

  static const _bodies = {
    NotifType.like: 'Tap to view their profile',
    NotifType.message: 'Don\'t leave them waiting...',
    NotifType.match: 'Start the conversation now!',
    NotifType.superLike: 'They really like you!',
  };

  Future<void> _onLoad(
      LoadNotifications event, Emitter<NotificationsState> emit) async {
    emit(const NotificationsLoading());
    final (users, failure) = await getUsersUsecase.call(results: 20);
    if (failure != null) {
      emit(NotificationsError(message: failure.message));
      return;
    }
    final all = users ?? [];
    final types = NotifType.values;

    final allNotifs = all.asMap().entries.map((e) {
      final idx = e.key;
      final user = e.value;
      final userRng = Random(user.id.hashCode + idx);
      final type = types[userRng.nextInt(types.length)];
      final titleList = _titles[type]!;
      final title =
          '${user.firstName} ${titleList[userRng.nextInt(titleList.length)]}';
      return NotifItem(
        id: '${user.id}_$idx',
        user: user,
        type: type,
        title: title,
        body: _bodies[type]!,
        timestamp: DateTime.now()
            .subtract(Duration(hours: userRng.nextInt(72))),
        isRead: idx > 3,
        hasActions: type == NotifType.like || type == NotifType.match,
      );
    }).toList();

    allNotifs.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final today = allNotifs.where((n) => n.timestamp.isToday).toList();
    final yesterday = allNotifs.where((n) => n.timestamp.isYesterday).toList();
    final thisWeek = allNotifs
        .where((n) => !n.timestamp.isToday && !n.timestamp.isYesterday)
        .toList();

    emit(NotificationsLoaded(
        today: today, yesterday: yesterday, thisWeek: thisWeek));
  }

  void _onMarkRead(MarkAsRead event, Emitter<NotificationsState> emit) {
    final curr = state;
    if (curr is NotificationsLoaded) {
      emit(NotificationsLoaded(
        today: curr.today
            .map((n) => n.id == event.notifId ? n.copyWith(isRead: true) : n)
            .toList(),
        yesterday: curr.yesterday
            .map((n) => n.id == event.notifId ? n.copyWith(isRead: true) : n)
            .toList(),
        thisWeek: curr.thisWeek
            .map((n) => n.id == event.notifId ? n.copyWith(isRead: true) : n)
            .toList(),
      ));
    }
  }
}

extension _DateHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool get isYesterday {
    final y = DateTime.now().subtract(const Duration(days: 1));
    return day == y.day && month == y.month && year == y.year;
  }
}
