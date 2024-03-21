import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/chat/chat_bubble.dart';
import 'package:viral_vibes_mobile/src/chat/chat_textfield.dart';
import 'package:viral_vibes_mobile/src/chat/chat_user.dart';
import 'package:viral_vibes_mobile/src/providers/live_chat_provider.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends ConsumerStatefulWidget {
  ChatPage(
      {super.key,
      ChatUser? user,
      required this.channel,
      required this.controller,
      required this.pageName})
      : _user = user ??
            ChatUser(
              user: '',
              id: '',
            );

  final ChatUser _user;

  final String pageName;
  final ScrollController controller;
  final WebSocketChannel channel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: theme == ThemeMode.light
          ? Palette.secondaryBackgroundColor
          : Palette.darkthemeContainerColor,
      appBar: CustomAppBar(
        title: nunitoTextWidget(
          widget.pageName,
          color: theme == ThemeMode.light
              ? Palette.darkthemeContainerColor
              : Palette.primaryBackgroundColor,
        ),
        centerTile: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final chatHistory = ref.watch(chatHistoryProvider);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10).r,
            width: double.infinity,
            child: ListView.builder(
              controller: widget.controller,
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: chatHistory[index].user.destination ==
                          widget._user.destination
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    (chatHistory[index] != (chatHistory.last))
                        ? (chatHistory[index]..isLast = 20)
                        : (chatHistory[index])
                  ],
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: ChatTextField(
        onSend: (message) {
          if (message.isNotEmpty) {
            final chat = ChatBubble(
              user: widget._user,
              textMessage: message.trim(),
            );

            ref.read(chatHistoryProvider.notifier).addToChatHistory(chat);
            widget.controller.animateTo(
                widget.controller.position.maxScrollExtent,
                duration: const Duration(milliseconds: 100),
                curve: Curves.bounceIn);
            widget.channel.sink.add(jsonEncode(chat.message));
          }
        },
      ),
    );
  }
}
