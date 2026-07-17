// lib/features/messages/presentation/bloc/messages_event.dart
import 'package:equatable/equatable.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();
  @override
  List<Object?> get props => [];
}

class LoadMessages extends MessagesEvent {
  const LoadMessages();
}

class RefreshMessages extends MessagesEvent {
  const RefreshMessages();
}
