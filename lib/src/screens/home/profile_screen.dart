import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/assets_provider/icons_provider.dart';
import 'package:viral_vibes_mobile/src/providers/providers.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.secondaryBackgroundColor,
        title: nunitoTextWidget(
          'Profile',
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeInLeft(
              duration: const Duration(
                milliseconds: 500,
              ),
              child: styledContainer(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              ImageProviders.manAvatar,
                            ),
                          ),
                          Gap(10),
                          Container(
                            height: 42,
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
                                nunitoTextWidget(
                                  'samuelsonowei04@gmail.com',
                                  fontSize: 11,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    Container(
                      height: 34,
                      child: Row(
                        children: [
                          nunitoTextWidget(
                            'Edit Profile',
                            fontWeight: FontWeight.w200,
                            color: Colors.black38,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FadeInLeft(
              duration: const Duration(
                milliseconds: 600,
              ),
              child: styledContainer(
                height: 150,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nunitoTextWidget(
                          'Personal Information',
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nunitoTextWidget(
                          'Account Security',
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nunitoTextWidget(
                          'App Setting',
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FadeInLeft(
              duration: const Duration(
                milliseconds: 700,
              ),
              child: styledContainer(
                height: 170,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nunitoTextWidget(
                            'Dark Mode',
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final switchValue =
                                  ref.watch(switchButtonStateNotifierProvider);
                              return Transform.scale(
                                scale: 1.2,
                                child: Switch(
                                  activeTrackColor: Palette.cardColor,
                                  value: switchValue,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  onChanged: (value) {
                                    ref
                                        .read(switchButtonStateNotifierProvider
                                            .notifier)
                                        .setState(value);
                                  },
                                  inactiveTrackColor:
                                      Palette.secondaryBackgroundColor,
                                  activeColor: Palette.cardColor,
                                  thumbColor: MaterialStateColor.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Palette.primaryBackgroundColor;
                                      }
                                      return Palette.primaryBackgroundColor;
                                    },
                                  ),
                                  trackOutlineColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .transparent; // Set outline color when disabled
                                      }
                                      return Colors.transparent;
                                    },
                                  ),
                                  splashRadius: 20,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nunitoTextWidget(
                          'Buy Tools',
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nunitoTextWidget(
                          'Support',
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FadeInLeft(
              duration: const Duration(
                milliseconds: 800,
              ),
              child: MaterialButton(
                onPressed: () {},
                height: 40,
                minWidth: MediaQuery.sizeOf(context).width,
                color: Palette.primaryBackgroundColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: nunitoTextWidget(
                  'Sign Out',
                  color: Palette.errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

Container styledContainer({
  Widget? child,
  double radius = 20,
  double? height,
  double? width,
}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.only(
      top: 10,
      bottom: 10,
      left: 15,
      right: 15,
    ),
    decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        color: Palette.primaryBackgroundColor,
        shadows: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0.1,
            blurRadius: 1,
          ),
        ]),
    child: child,
  );
}
