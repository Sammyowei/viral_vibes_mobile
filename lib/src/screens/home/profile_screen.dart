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

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, this.user});

  final User? user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final theme = ref.watch(themeProvider);
      return Scaffold(
        backgroundColor: (theme == ThemeMode.light)
            ? Palette.secondaryBackgroundColor
            : Palette.darkthemeContainerColor,
        appBar: AppBar(
          backgroundColor: (theme == ThemeMode.light)
              ? Palette.secondaryBackgroundColor
              : Palette.darkthemeContainerColor,
          title: nunitoTextWidget('Profile',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color:
                  (theme == ThemeMode.light) ? Colors.black87 : Colors.white),
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
                  height: 130.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage: AssetImage(
                                ImageProviders.manAvatar,
                              ),
                            ),
                            Gap(10),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      nunitoTextWidget(
                                        '${widget.user?.userName}',
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: (theme == ThemeMode.light)
                                            ? Colors.black87
                                            : Colors.white,
                                      ),
                                      Gap(4),
                                      (widget.user != null &&
                                              widget.user?.isVerified == true)
                                          ? Image.asset(
                                              IconProvider.verifiedIcon,
                                              height: 15.h,
                                            )
                                          : Container(
                                              height: 15.h,
                                              width: 60.w,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(2)
                                                          .r,
                                                  side: BorderSide(
                                                      color:
                                                          Palette.errorColor),
                                                ),
                                              ),
                                              child: Center(
                                                child: nunitoTextWidget(
                                                    'NOT VERIFIED',
                                                    fontSize: 8.sp,
                                                    color: Palette.errorColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onDoubleTap: () async =>
                                        ref.refresh(getUserProvider.future),
                                    child: nunitoTextWidget(
                                      '${widget.user?.emailAddress}',
                                      fontSize: 11.sp,
                                      color: (theme == ThemeMode.light)
                                          ? Colors.black87
                                          : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            )
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
                  height: 100.h,
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nunitoTextWidget(
                            'Personal Information',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                            color: (theme == ThemeMode.light)
                                ? Colors.black87
                                : Colors.white,
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(RouteName.personalInfo);
                            },
                            child: Icon(
                              Icons.navigate_next_rounded,
                              size: 30.r,
                            ),
                          )
                        ],
                      ),

                      Divider(
                        color: (theme == ThemeMode.light)
                            ? Colors.black12
                            : Colors.white12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nunitoTextWidget(
                            'Account settings',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                            color: (theme == ThemeMode.light)
                                ? Colors.black87
                                : Colors.white,
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.navigate_next_rounded,
                              size: 30.h,
                            ),
                          ),
                        ],
                      ),
                      // Divider(
                      //   color: (theme == ThemeMode.light)
                      //       ? Colors.black12
                      //       : Colors.white12,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     nunitoTextWidget(
                      //       'App Setting',
                      //       fontSize: 13.sp,
                      //       fontWeight: FontWeight.w300,
                      //       color: (theme == ThemeMode.light)
                      //           ? Colors.black87
                      //           : Colors.white,
                      //     ),
                      //     GestureDetector(
                      //       child: Icon(
                      //         Icons.navigate_next_rounded,
                      //         size: 30.h,
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              FadeInLeft(
                duration: const Duration(
                  milliseconds: 700,
                ),
                child: styledContainer(
                  height: 220.h,
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            nunitoTextWidget(
                              'Dark Mode',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w300,
                              color: (theme == ThemeMode.light)
                                  ? Colors.black87
                                  : Colors.white,
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final switchValue =
                                    (theme == ThemeMode.light) ? false : true;
                                return Transform.scale(
                                  scale: 1.2.h,
                                  child: Switch(
                                    activeTrackColor: Palette.cardColor,
                                    value: switchValue,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    onChanged: (value) {
                                      ref
                                          .read(themeProvider.notifier)
                                          .toggleTheme(value);
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
                                    trackOutlineColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors
                                              .transparent; // Set outline color when disabled
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                    splashRadius: 20.r,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: (theme == ThemeMode.light)
                            ? Colors.black12
                            : Colors.white12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nunitoTextWidget(
                            'Buy Tools',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                            color: (theme == ThemeMode.light)
                                ? Colors.black87
                                : Colors.white,
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(RouteName.marketplace);
                            },
                            child: Icon(
                              Icons.navigate_next_rounded,
                              size: 30.h,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: (theme == ThemeMode.light)
                            ? Colors.black12
                            : Colors.white12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nunitoTextWidget(
                            'Support',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                            color: (theme == ThemeMode.light)
                                ? Colors.black87
                                : Colors.white,
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(RouteName.supportPage);
                            },
                            child: Icon(
                              Icons.navigate_next_rounded,
                              size: 30.h,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: (theme == ThemeMode.light)
                            ? Colors.black12
                            : Colors.white12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nunitoTextWidget(
                            'Refer and Earn',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                            color: (theme == ThemeMode.light)
                                ? Colors.black87
                                : Colors.white,
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(RouteName.referral);
                            },
                            child: Icon(
                              Icons.navigate_next_rounded,
                              size: 30.h,
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
                  onPressed: () {
                    GoRouter.of(context).goNamed(RouteName.authentication);
                  },
                  height: 40.h,
                  minWidth: MediaQuery.sizeOf(context).width,
                  color: (theme == ThemeMode.light)
                      ? Palette.primaryBackgroundColor
                      : Palette.dartThemeBAckgoundColor.withOpacity(0.4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: nunitoTextWidget(
                    'Sign Out',
                    color: Palette.errorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget styledContainer({
  Widget? child,
  double radius = 20,
  double? height,
  double? width,
}) {
  return Consumer(builder: (_, ref, __) {
    final theme = ref.watch(themeProvider);
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 15,
        right: 15,
      ).r,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          color: (theme == ThemeMode.light)
              ? Palette.primaryBackgroundColor
              : Palette.dartThemeBAckgoundColor.withOpacity(0.4),
          shadows: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.1,
              blurRadius: 1,
            ),
          ]),
      child: child,
    );
  });
}
