import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:viral_vibes_mobile/src/models/user_model.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';

import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/assets_provider/image_provider.dart'
    as img;

import '../../providers/providers.dart';
import '../../widgets/custom_wallet_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.user});

  final User? user;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final serviceName = <String>[
    'Instagram',
    'Telegram',
    'Twitter',
    'Youtube',
    'TikTok',
    'Facebook',
    'Spotify',
    'Snapchat',
  ];

  final serviceImage = <String>[
    IconProvider.instaIcon,
    IconProvider.telegramIcon,
    IconProvider.twitterIcon,
    IconProvider.youtubeIcon,
    IconProvider.tiktokIcon,
    IconProvider.facebookIcon,
    IconProvider.spotifyIcon,
    IconProvider.snapChatIcon,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: (theme == ThemeMode.light)
          ? Palette.secondaryBackgroundColor
          : Palette.darkthemeContainerColor,
      appBar: appBar(context, ref, widget.user),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 20,
          right: 20,
        ).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeInRight(
              child: walletCard(context, size, user: widget.user!),
            ),
            Gap(10),
            FadeInRight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  nunitoTextWidget(
                    'Advertise your promotion',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: (theme == ThemeMode.light)
                        ? Colors.black87
                        : Palette.alternateTertiary,
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed(RouteName.service);
                    },
                    child: nunitoTextWidget(
                      'See more',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Palette.tetiaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => GestureDetector(
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(RouteName.serviceCategory, queryParameters: {
                      'serviceName': serviceName[index],
                    });
                  },
                  child: FadeInLeft(
                    duration: Duration(
                      milliseconds: 890 + (index * cos(60).toInt() + 100),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: (theme == ThemeMode.light)
                              ? Palette.primaryBackgroundColor
                              : Palette.alternateTertiary.withOpacity(0.6),
                          child: Image.asset(
                            serviceImage[index],
                            height: 25.h,
                          ),
                        ),
                        nunitoTextWidget(
                          serviceName[index],
                          fontSize: 12.sp,
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(RouteName.serviceCategory,
                        queryParameters: {
                          'serviceName': serviceName[index + 4]
                        });
                  },
                  child: FadeInLeft(
                    duration: Duration(
                      milliseconds: 890 + (index * cos(60).toInt() + 100),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: (theme == ThemeMode.light)
                              ? Palette.primaryBackgroundColor
                              : Palette.alternateTertiary.withOpacity(0.6),
                          child: Image.asset(
                            serviceImage[index + 4],
                            height: 25.h,
                          ),
                        ),
                        nunitoTextWidget(
                          serviceName[index + 4],
                          fontSize: 12.sp,
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(30),
            FadeInUp(
              child: GestureDetector(
                child: ReferalContainer(size: size),
              ),
            ),
            Gap(20)
          ],
        ),
      ),
    );
  }
}

class ReferalContainer extends StatelessWidget {
  const ReferalContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.deepPurpleAccent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
            ).r,
            width: size.width * 0.5,
            child: Center(
              child: nunitoTextWidget(
                'Get up to 20% for both you and your friends 🎉',
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
          Image.asset(
            img.ImageProviders.marketingImage,
            height: 100.h,
          ),
        ],
      ),
    );
  }
}

AppBar appBar(BuildContext context, WidgetRef ref, User? user) {
  final theme = ref.watch(themeProvider);
  return AppBar(
    backgroundColor: (theme == ThemeMode.light)
        ? Palette.secondaryBackgroundColor
        : Palette.darkthemeContainerColor,
    surfaceTintColor: (theme == ThemeMode.light)
        ? Palette.secondaryBackgroundColor
        : Palette.darkthemeContainerColor,
    title: Row(
      children: [
        FadeInLeft(
          child: CircleAvatar(
            radius: 28.r,
            backgroundImage: AssetImage(
              ImageProviders.manAvatar,
            ),
          ),
        ),
        const Gap(10),
        FadeInDown(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    nunitoTextWidget(
                      '${user?.userName}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: (theme == ThemeMode.light)
                          ? Colors.black87
                          : Colors.white,
                    ),
                    Gap(4),
                    (user != null && user.isVerified == true)
                        ? Image.asset(
                            IconProvider.verifiedIcon,
                            height: 15.h,
                          )
                        : GestureDetector(
                            onTap: () async =>
                                ref.refresh(getUserProvider.future),
                            child: Container(
                              height: 15.h,
                              width: 60.w,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2).r,
                                  side: BorderSide(color: Palette.errorColor),
                                ),
                              ),
                              child: Center(
                                child: nunitoTextWidget('NOT VERIFIED',
                                    fontSize: 8.sp,
                                    color: Palette.errorColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final greeting = ref.watch(greetingStateNotifierProvider);
                    return nunitoTextWidget(
                      greeting,
                      fontSize: 12.sp,
                      color: (theme == ThemeMode.light)
                          ? Colors.black87
                          : Colors.white,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    ),
    actions: [
      FadeInRight(
        child: GestureDetector(
          onTap: () => GoRouter.of(context).pushNamed(
            RouteName.notifications,
          ),
          child: CircleAvatar(
            // backgroundColor:
            //     (theme == ThemeMode.light) ? Colors.black87 : Colors.white,
            child: Icon(
              Icons.notifications,
              size: 20,
              color: Palette.tetiaryColor,
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
