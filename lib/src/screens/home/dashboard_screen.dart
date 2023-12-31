// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/assets_provider/icons_provider.dart';
import 'package:viral_vibes_mobile/src/providers/providers.dart';
import 'package:viral_vibes_mobile/src/screens/home/order/my_order_screen.dart';
import 'package:viral_vibes_mobile/src/screens/home/profile_screen.dart';
import 'package:viral_vibes_mobile/src/screens/home/wallet_screen.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  late TimeGreatingNotifier greetingNotifier;
  @override
  @override
  void didChangeDependencies() {
    greetingNotifier = ref.watch(greetingStateNotifierProvider.notifier);
    greetingNotifier.startCheckingTime();
    super.didChangeDependencies();
  }

  final screens = [
    const HomeScreen(),
    const MyOrderScreen(),
    const WalletScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondaryBackgroundColor,
      body: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavStateNotifierProvider);
          return screens[currentIndex];
        },
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, _) {
        final currentIndex = ref.watch(bottomNavStateNotifierProvider);
        return BottomNavigationBar(
          enableFeedback: true,
          selectedLabelStyle: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.nunito(),
          showUnselectedLabels: false,
          mouseCursor: MouseCursor.defer,
          type: BottomNavigationBarType.shifting,
          onTap: (value) {
            ref.read(bottomNavStateNotifierProvider.notifier).goTo(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                IconProvider.homeSvg,
                height: 22,
                color: (currentIndex == 0)
                    ? Palette.tetiaryColor
                    : const Color(0xFF0039a6).withOpacity(0.4),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                IconProvider.shoppingBag,
                height: 22,
                color: (currentIndex == 1)
                    ? Palette.tetiaryColor
                    : const Color(0xFF0039a6).withOpacity(0.4),
              ),
              label: 'My Order',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                IconProvider.wallet,
                height: 22,
                color: (currentIndex == 2)
                    ? Palette.tetiaryColor
                    : const Color(0xFF0039a6).withOpacity(0.4),
              ),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                IconProvider.userSvg,
                height: 22,
                color: (currentIndex == 3)
                    ? Palette.tetiaryColor
                    : const Color(0xFF0039a6).withOpacity(0.4),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Palette.tetiaryColor,
          unselectedItemColor: Color(0xFF0039a6).withOpacity(0.4),
        );
      }),
    );
  }
}
