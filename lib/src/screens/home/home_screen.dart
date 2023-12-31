import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/assets_provider/icons_provider.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/assets_provider/image_provider.dart'
    as img;
import 'package:viral_vibes_mobile/src/widgets/custom_wallet_card.dart';

import '../../providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final serviceName = <String>[
    'Instagram',
    'Telegram',
    'X-Twitter',
    'Youtube',
    'TikTok',
    'Facebook',
    'Spotify',
    'Thread',
  ];

  final serviceImage = <String>[
    IconProvider.instaIcon,
    IconProvider.telegramIcon,
    IconProvider.twitterIcon,
    IconProvider.youtubeIcon,
    IconProvider.tiktokIcon,
    IconProvider.facebookIcon,
    IconProvider.spotifyIcon,
    IconProvider.threadSvgIcon,
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Palette.secondaryBackgroundColor,
      appBar: appBar(context),
      body: Container(
        padding: const EdgeInsets.only(
          top: 15,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeInRight(
              child: walletCard(context, size),
            ),
            const Gap(10),
            FadeInRight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  nunitoTextWidget(
                    'Advertise your promotion',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed(RouteName.service);
                    },
                    child: nunitoTextWidget(
                      'See more',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Palette.tetiaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => GestureDetector(
                  child: FadeInLeft(
                    duration: Duration(
                      milliseconds: 890 + (index * cos(60).toInt() + 100),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Palette.primaryBackgroundColor,
                          child: Image.asset(
                            serviceImage[index],
                            height: 25,
                          ),
                        ),
                        nunitoTextWidget(
                          serviceName[index],
                          fontSize: 12,
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
                  child: FadeInLeft(
                    duration: Duration(
                      milliseconds: 890 + (index * cos(60).toInt() + 100),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Palette.primaryBackgroundColor,
                          child: ((index + 4) != serviceImage.length - 1)
                              ? Image.asset(
                                  serviceImage[index + 4],
                                  height: 25,
                                )
                              : SvgPicture.asset(
                                  serviceImage[index + 4],
                                  height: 25,
                                ),
                        ),
                        nunitoTextWidget(
                          serviceName[index + 4],
                          fontSize: 12,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Gap(30),
            FadeInUp(
              child: GestureDetector(
                child: Container(
                  height: 120,
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
                        ),
                        width: size.width * 0.5,
                        child: Center(
                          child: nunitoTextWidget(
                            'Get a ₦500 Reward by referring a friend! 🎉',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Image.asset(
                        img.ImageProviders.marketingImage,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(20)
          ],
        ),
      ),
    );
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Palette.secondaryBackgroundColor,
    title: Row(
      children: [
        FadeInLeft(
          child: CircleAvatar(
            radius: 28,
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
                      'SammyOwei',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    Gap(4),
                    Image.asset(
                      IconProvider.verifiedIcon,
                      height: 15,
                    )
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final greeting = ref.watch(greetingStateNotifierProvider);
                    return nunitoTextWidget(
                      greeting,
                      fontSize: 12,
                      color: Colors.black54,
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
            backgroundColor: Palette.primaryBackgroundColor,
            child: const Icon(
              Icons.notifications,
              size: 20,
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
