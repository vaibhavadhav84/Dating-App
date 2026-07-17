// lib/features/notifications/presentation/bloc/notifications_event.dart
import 'package:equatable/equatable.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationsEvent {
  const LoadNotifications();
}

class MarkAsRead extends NotificationsEvent {
  final String notifId;
  const MarkAsRead({required this.notifId});
  @override
  List<Object?> get props => [notifId];
}
