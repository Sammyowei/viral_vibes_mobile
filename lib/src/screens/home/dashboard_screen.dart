// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:better_skeleton/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:viral_vibes_mobile/src/providers/order_status_provider.dart';
import 'package:viral_vibes_mobile/src/providers/providers.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_data_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
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
  late final AnimationController animationController;
  @override
  void didChangeDependencies() {
    greetingNotifier = ref.watch(greetingStateNotifierProvider.notifier);
    greetingNotifier.startCheckingTime();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    final insance = ref.refresh(getUserProvider.future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final userProviderr = ref.watch(getUserProvider);

          return userProviderr.when(
            data: (data) {
              final userData = ref.watch(dataGetterProvider);
              final service = ref.refresh(serviceProvider.future);

              userData.userData = data!.toJson();

              final screens = [
                HomeScreen(user: data),
                MyOrderScreen(user: data),
                WalletScreen(user: data),
                ProfileScreen(user: data)
              ];

              final currentIndex = ref.watch(bottomNavStateNotifierProvider);
              return RefreshIndicator(
                onRefresh: () {
                  print("hello WOrld");
                  final user = ref.refresh(getUserProvider.future);
                  return ref.refresh(orderStatusDataProvider.future);
                },
                child: screens[currentIndex],
              );
            },
            error: (error, stackTrace) {
              return Container(
                child: Center(
                  child: MaterialButton(
                    onPressed: () async {
                      final Identifier = ref.watch(userProvider);

                      Identifier.identifier;

                      getService(ref);
                      refUserProvider(ref);
                    },
                    child: Text('Refersh'),
                  ),
                ),
              );
            },
            loading: () {
              // return Consumer(
              //   builder: (context, ref, child) {
              //     const screens = [
              //       HomeScreen(),
              //       MyOrderScreen(),
              //       WalletScreen(),
              //       ProfileScreen()
              //     ];

              //     final currentIndex =
              //         ref.watch(bottomNavStateNotifierProvider);
              //     return Skeletonizer(
              //       child: screens[currentIndex],
              //     );
              //   },
              // );

              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, _) {
        final currentIndex = ref.watch(bottomNavStateNotifierProvider);
        final theme = ref.watch(themeProvider);
        return BottomNavigationBar(
          enableFeedback: true,
          selectedLabelStyle: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.nunito(),
          showUnselectedLabels: true,
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
                    : (theme == ThemeMode.light)
                        ? const Color(0xFF0039a6).withOpacity(0.4)
                        : Colors.white24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                IconProvider.shoppingBag,
                height: 22,
                color: (currentIndex == 1)
                    ? Palette.tetiaryColor
                    : (theme == ThemeMode.light)
                        ? const Color(0xFF0039a6).withOpacity(0.4)
                        : Colors.white24,
              ),
              label: 'My Order',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                IconProvider.wallet,
                height: 22,
                color: (currentIndex == 2)
                    ? Palette.tetiaryColor
                    : (theme == ThemeMode.light)
                        ? const Color(0xFF0039a6).withOpacity(0.4)
                        : Colors.white24,
              ),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                IconProvider.userSvg,
                height: 22,
                color: (currentIndex == 3)
                    ? Palette.tetiaryColor
                    : (theme == ThemeMode.light)
                        ? const Color(0xFF0039a6).withOpacity(0.4)
                        : Colors.white24,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Palette.tetiaryColor,
          unselectedItemColor: (theme == ThemeMode.light)
              ? const Color(0xFF0039a6).withOpacity(0.4)
              : Colors.white24,
        );
      }),
    );
  }
}

Future<void> getService(WidgetRef ref) async {
  return ref
      .refresh(serviceProvider.future)
      .then((value) => print('Haaaaaaa We rock'));
}

Future<void> refUserProvider(WidgetRef ref) async {
  final user = ref.watch(userProvider);

  // user.identifier = 'samuelsonowei660@gmail.com';
  return ref
      .refresh(getUserProvider.future)
      .then((value) => print(value?.emailAddress));
}
