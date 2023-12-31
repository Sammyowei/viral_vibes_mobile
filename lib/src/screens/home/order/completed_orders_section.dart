import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/nav_bar_state_notifier.dart';

import '../../../src.dart';

class CompletedOrders extends ConsumerStatefulWidget {
  const CompletedOrders({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompletedOrdersState();
}

class _CompletedOrdersState extends ConsumerState<CompletedOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                    color: Colors.black38,
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
      ),
    );
  }
}
