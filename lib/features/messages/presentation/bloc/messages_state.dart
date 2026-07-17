// lib/features/messages/presentation/bloc/messages_state.dart
import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/user_entity.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();
  @override
  List<Object?> get props => [];
}

class MessagesInitial extends MessagesState {
  const MessagesInitial();
}

class MessagesLoading extends MessagesState {
  const MessagesLoading();
}

class MessagesLoaded extends MessagesState {
  final List<ChatItem> chats;
  final List<UserEntity> stories;

  const MessagesLoaded({required this.chats, required this.stories});

  @override
  List<Object?> get props => [chats, stories];
}

class MessagesError extends MessagesState {
  final String message;
  const MessagesError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ChatItem extends Equatable {
  final UserEntity user;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool hasStory;

  const ChatItem({
    required this.user,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.hasStory = false,
  });

  @override
  List<Object?> get props =>
      [user, lastMessage, timestamp, unreadCount, hasStory];
}
