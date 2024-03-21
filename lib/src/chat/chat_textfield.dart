import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/obscured_text_state_notifier.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class ChatTextField extends ConsumerWidget {
  final void Function(String message) onSend;
  const ChatTextField({super.key, required this.onSend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _textEditingController = TextEditingController();
    final size = MediaQuery.sizeOf(context);
    final theme = ref.watch(themeProvider);
    final maxWidth = size.width * 0.9;

    const maxHeight = 100.0;

    return Container(
      constraints: BoxConstraints(
          maxHeight: maxHeight, maxWidth: maxWidth, minHeight: maxHeight),
      decoration: ShapeDecoration(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30).r),
        color: theme == ThemeMode.light
            ? Palette.primaryBackgroundColor
            : Palette.alternateTertiary.withOpacity(0.2),
      ),
      padding:
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 25).r,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _textEditingController,
              onFieldSubmitted: (value) {
                print(value);
              },
              onChanged: (value) {
                if (value.isEmpty) {
                  ref.read(sendButtonProvider.notifier).show();
                } else {
                  ref.read(sendButtonProvider.notifier).hide();
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Message',
                hintStyle: GoogleFonts.nunito(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              maxLines: 3,
              minLines: 1,
            ),
          ),
          Gap(10),
          Consumer(builder: (context, ref, _) {
            final showButton = ref.watch(sendButtonProvider);
            return showButton == true
                ? GestureDetector(
                    onTap: () {
                      onSend(
                        _textEditingController.text,
                      );

                      _textEditingController.clear();
                    },
                    child: Icon(
                      Icons.send_rounded,
                      color: Palette.tetiaryColor,
                    ),
                  )
                : SizedBox();
          }),
        ],
      ),
    );
  }
}
