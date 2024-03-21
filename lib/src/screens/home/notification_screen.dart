import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/palette/palette.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
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
    return Consumer(builder: (_, ref, __) {
      final theme = ref.watch(themeProvider);
      return Scaffold(
          backgroundColor: (theme == ThemeMode.light)
              ? Palette.secondaryBackgroundColor
              : Palette.darkthemeContainerColor,
          appBar: const CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100.r,
                  child: Image.asset(
                    src.ImageProviders.notificationBell,
                    height: 140.h,
                    width: 140.w,
                  ),
                ),
                Gap(20),
                nunitoTextWidget(
                  "You haven't engaged in any activity so far 🚫, start using viral vibe to rack your activities up.",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                  color: (theme == ThemeMode.light)
                      ? Colors.black87
                      : Palette.primaryBackgroundColor,
                ),
              ],
            ),
          ));
    });
  }
}
