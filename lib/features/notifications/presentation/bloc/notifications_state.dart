// lib/features/notifications/presentation/bloc/notifications_state.dart
import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/user_entity.dart';

enum NotifType { like, message, match, superLike }

class NotifItem extends Equatable {
  final String id;
  final UserEntity user;
  final NotifType type;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;
  final bool hasActions;

  const NotifItem({
    required this.id,
    required this.user,
    required this.type,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
    this.hasActions = false,
  });

  NotifItem copyWith({bool? isRead}) => NotifItem(
        id: id,
        user: user,
        type: type,
        title: title,
        body: body,
        timestamp: timestamp,
        isRead: isRead ?? this.isRead,
        hasActions: hasActions,
      );

  @override
  List<Object?> get props =>
      [id, user, type, title, body, timestamp, isRead, hasActions];
}

sealed class NotificationsState extends Equatable {
  const NotificationsState();
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationsState {
  final List<NotifItem> today;
  final List<NotifItem> yesterday;
  final List<NotifItem> thisWeek;

  const NotificationsLoaded({
    required this.today,
    required this.yesterday,
    required this.thisWeek,
  });

  @override
  List<Object?> get props => [today, yesterday, thisWeek];
}

class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError({required this.message});
  @override
  List<Object?> get props => [message];
}
