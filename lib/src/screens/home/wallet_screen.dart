import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/nav_bar_state_notifier.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_wallet_card.dart';

import '../../src.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Palette.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.secondaryBackgroundColor,
        title: nunitoTextWidget(
          'Wallet',
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeInLeft(
              child: walletCard(context, size),
            ),
            FadeInRight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  nunitoTextWidget(
                    'Recent Activities',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    child: nunitoTextWidget('See all',
                        color: Palette.tetiaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )
                ],
              ),
            ),
            FadeInUp(
              child: SizedBox(
                height: 250,
                width: size.width * 0.7,
                child: Column(
                  children: [
                    Image.asset(
                      ImageProviders.emptyBox,
                      height: 140,
                    ),
                    nunitoTextWidget(
                      'Oops, nothing to show here!',
                      fontWeight: FontWeight.w600,
                    ),
                    nunitoTextWidget(
                      'Looks like you don\'t have any transactions at the moment.',
                      textAlign: TextAlign.center,
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
            ),
            FadeInUp(
              child: MaterialButton(
                onPressed: () {
                  ref.read(bottomNavStateNotifierProvider.notifier).goTo(0);
                },
                color: Palette.cardColor,
                height: 40,
                minWidth: size.width,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: nunitoTextWidget(
                  'Make your first order',
                  color: Palette.primaryBackgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
