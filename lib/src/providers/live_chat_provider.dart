import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/chat/chat_bubble.dart';

class ChatHistoryNotifier extends StateNotifier<List<ChatBubble>> {
  ChatHistoryNotifier() : super([]);

  void addToChatHistory(ChatBubble chat) {
    state = [...state, chat];
  }

  void clearChat() {
    state = [];
  }
}

final chatHistoryProvider =
    StateNotifierProvider<ChatHistoryNotifier, List<ChatBubble>>((ref) {
  return ChatHistoryNotifier();
});
