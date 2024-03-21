// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/chat/chat_user.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class ChatBubble extends ConsumerWidget {
  final ChatUser user;

  final String message;

  double? last;
  ChatBubble({super.key, required this.user, String? textMessage, this.last})
      : message = textMessage ??
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor ";

  set isLast(double? now) {
    last = now;
  }

  final date = DateTime.now();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double maxWidth = MediaQuery.sizeOf(context).width * 0.65;

    final theme = ref.watch(themeProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              padding: const EdgeInsets.all(12).r,
              margin: const EdgeInsets.symmetric(vertical: 2).r,
              decoration: BoxDecoration(
                color: user.destination != DestinationType.reciever
                    ? Palette.tetiaryColor.withOpacity(0.9)
                    : Palette.alternateTertiary
                        .withOpacity(0.3), // Customize the color as needed
                borderRadius: BorderRadius.only(
                  topLeft: user.destination != DestinationType.reciever
                      ? const Radius.circular(90).r
                      : const Radius.circular(40).r,
                  bottomLeft: user.destination != DestinationType.reciever
                      ? const Radius.circular(90).r
                      : Radius.circular(last ?? 0).r,
                  topRight: user.destination != DestinationType.reciever
                      ? const Radius.circular(90).r
                      : const Radius.circular(30).r,
                  bottomRight: user.destination != DestinationType.reciever
                      ? Radius.circular(last ?? 0)
                      : const Radius.circular(30),
                ),
              ),
              child: nunitoTextWidget(message,
                  color: theme == ThemeMode.light
                      ? user.destination != DestinationType.reciever
                          ? Colors.white
                          : Colors.black87
                      : Colors.white,
                  fontSize: 15.sp),
            ),
          ],
        ),
      ],
    );
  }
}

// Chat PAge 

 