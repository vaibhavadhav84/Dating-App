// lib/features/messages/presentation/bloc/messages_bloc.dart
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/usecases/get_users_usecase.dart';
import 'messages_event.dart';
import 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final GetUsersUsecase getUsersUsecase;

  MessagesBloc({required this.getUsersUsecase})
      : super(const MessagesInitial()) {
    on<LoadMessages>(_onLoad);
    on<RefreshMessages>(_onRefresh);
  }

  static const List<String> _lastMessages = [
    'Hey! How are you doing? 😊',
    'That sounds like a great idea! 🎉',
    'Would love to grab coffee sometime ☕',
    'I just saw your profile and wow! 😍',
    'Are you free this weekend?',
    'Haha that\'s so funny! 😂',
    'I think we have a lot in common 💕',
    'Looking forward to meeting you!',
    'What kind of music do you like?',
    'You seem really interesting 🌟',
  ];

  Future<void> _onLoad(LoadMessages event, Emitter<MessagesState> emit) async {
    emit(const MessagesLoading());
    final (users, failure) = await getUsersUsecase.call(results: 20);
    if (failure != null) {
      emit(MessagesError(message: failure.message));
      return;
    }
    final all = users ?? [];

    final chats = all.take(12).toList().asMap().entries.map((e) {
      final user = e.value;
      final userRng = Random(user.id.hashCode);
      return ChatItem(
        user: user,
        lastMessage: _lastMessages[userRng.nextInt(_lastMessages.length)],
        timestamp: DateTime.now()
            .subtract(Duration(minutes: userRng.nextInt(1440))),
        unreadCount: userRng.nextBool() ? userRng.nextInt(9) + 1 : 0,
        hasStory: userRng.nextBool(),
      );
    }).toList();

    // Sort: unread first, then by timestamp
    chats.sort((a, b) {
      if (a.unreadCount > 0 && b.unreadCount == 0) return -1;
      if (a.unreadCount == 0 && b.unreadCount > 0) return 1;
      return b.timestamp.compareTo(a.timestamp);
    });

    final stories =
        all.where((u) => Random(u.id.hashCode).nextBool()).take(8).toList();

    emit(MessagesLoaded(chats: chats, stories: stories));
  }

  Future<void> _onRefresh(
      RefreshMessages event, Emitter<MessagesState> emit) async {
    add(const LoadMessages());
  }
}
