import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/nav_bar_state_notifier.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class PendingOrders extends ConsumerStatefulWidget {
  const PendingOrders({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends ConsumerState<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final theme = ref.watch(themeProvider);
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 70,
          ),
          Container(
            height: 231,
            child: Column(
              children: [
                Image.asset(
                  ImageProviders.emptyBox,
                  height: 170,
                ),
                nunitoTextWidget(
                  'Oops, nothing to see here!',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: (theme == ThemeMode.light)
                      ? Colors.black87
                      : Palette.primaryBackgroundColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: nunitoTextWidget(
                    "Looks like you don't have any task available yet. Keep an eye out  for important updates from us.",
                    fontSize: 13,
                    textAlign: TextAlign.center,
                    color: (theme == ThemeMode.light)
                        ? Colors.black38
                        : Palette.primaryBackgroundColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              ref.read(bottomNavStateNotifierProvider.notifier).goTo(0);
            },
            color: Palette.cardColor,
            minWidth: MediaQuery.sizeOf(context).width,
            height: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: nunitoTextWidget(
              'Make your first order',
              fontSize: 15,
              color: Palette.primaryBackgroundColor,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
    });
  }
}
