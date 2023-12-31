import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/palette/palette.dart';
import 'package:viral_vibes_mobile/src/src.dart' as src;
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';
import 'package:viral_vibes_mobile/src/widgets/nunito_text_widget.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: src.Palette.secondaryBackgroundColor,
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: Palette.primaryBackgroundColor,
                child: Image.asset(
                  src.ImageProviders.notificationBell,
                  height: 140,
                  width: 140,
                ),
              ),
              nunitoTextWidget(
                "You haven't engaged in any activity so far 🚫, start using viral vibe to rack your activities up.",
                fontSize: 12,
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
