import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_data_provider.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

class ReferalScreen extends ConsumerStatefulWidget {
  const ReferalScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReferalScreenState();
}

class _ReferalScreenState extends ConsumerState<ReferalScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final user = ref.watch(userDataProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: nunitoTextWidget(
          'Refer and Earn',
          fontWeight: FontWeight.w600,
          color: theme == ThemeMode.light
              ? Colors.black87
              : Palette.primaryBackgroundColor,
          fontSize: 18.sp,
        ),
      ),
      backgroundColor: theme == ThemeMode.light
          ? Palette.secondaryBackgroundColor
          : Palette.darkthemeContainerColor,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ).r,
        child: Column(
          children: [
            ReferalContainer(
              size: MediaQuery.sizeOf(context),
            ),
            const Gap(20),
            Container(
              height: 140.h,
              width: MediaQuery.sizeOf(context).width,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20).r,
                ),
                color: theme == ThemeMode.light
                    ? Palette.primaryBackgroundColor
                    : Palette.dartThemeBAckgoundColor.withOpacity(0.4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  nunitoTextWidget(
                    'Invite family & friends',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: theme == ThemeMode.light
                        ? Colors.black87
                        : Palette.primaryBackgroundColor,
                  ),
                  nunitoTextWidget(
                    'copy your code, and share it with your friends ',
                    fontSize: 12.sp,
                    color: theme == ThemeMode.light
                        ? Colors.black87
                        : Palette.primaryBackgroundColor.withOpacity(0.5),
                  ),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  Container(
                    height: 45.h,
                    padding: const EdgeInsets.only(
                            left: 20, right: 10, top: 5, bottom: 5)
                        .r,
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                      color: theme == ThemeMode.light
                          ? Palette.secondaryBackgroundColor
                          : Palette.darkthemeContainerColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            return nunitoTextWidget(
                              user.referalCode,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: theme == ThemeMode.light
                                  ? Colors.black87
                                  : Palette.primaryBackgroundColor,
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: user.referalCode));

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 700),
                                  content: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 20.h,
                                        width: MediaQuery.sizeOf(context).width,
                                        child: nunitoTextWidget(
                                            'Referal code copied',
                                            color:
                                                Palette.primaryBackgroundColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp),
                                      )),
                                  backgroundColor: Colors.teal[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5).r,
                                  ),
                                  dismissDirection: DismissDirection.vertical,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height -
                                        170,
                                    left: 10,
                                    right: 10,
                                  ).r,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 45.h,
                            width: 70.w,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Palette.cardColor,
                            ),
                            child: Center(
                              child: nunitoTextWidget(
                                'Copy',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: Palette.primaryBackgroundColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(40),
            Container(
              height: 200.h,
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20).r,
                ),
                color: theme == ThemeMode.light
                    ? Palette.primaryBackgroundColor
                    : Palette.dartThemeBAckgoundColor.withOpacity(0.4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(0),
                  nunitoTextWidget(
                    "How it works?",
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: theme == ThemeMode.light
                        ? Colors.black87
                        : Palette.primaryBackgroundColor,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme == ThemeMode.light
                              ? Palette.secondaryBackgroundColor
                              : Palette.darkthemeContainerColor,
                        ),
                        child: Center(
                          child: nunitoTextWidget('1',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: theme == ThemeMode.light
                                  ? Colors.black54
                                  : Palette.primaryBackgroundColor),
                        ),
                      ),
                      Gap(10),
                      nunitoTextWidget(
                        'Invite your friends and family.',
                        fontSize: 12.sp,
                        color: theme == ThemeMode.light
                            ? Colors.black54
                            : Palette.secondaryBackgroundColor.withOpacity(0.6),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme == ThemeMode.light
                              ? Palette.secondaryBackgroundColor
                              : Palette.darkthemeContainerColor,
                        ),
                        child: Center(
                          child: nunitoTextWidget('2',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: theme == ThemeMode.light
                                  ? Colors.black54
                                  : Palette.primaryBackgroundColor),
                        ),
                      ),
                      Gap(10),
                      nunitoTextWidget(
                        'when they make a minimum deposit of ₦2000',
                        fontSize: 12.sp,
                        color: theme == ThemeMode.light
                            ? Colors.black54
                            : Palette.secondaryBackgroundColor.withOpacity(0.6),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme == ThemeMode.light
                              ? Palette.secondaryBackgroundColor
                              : Palette.darkthemeContainerColor,
                        ),
                        child: Center(
                          child: nunitoTextWidget('3',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: theme == ThemeMode.light
                                  ? Colors.black54
                                  : Palette.primaryBackgroundColor),
                        ),
                      ),
                      Gap(10),
                      nunitoTextWidget(
                        'You both get 12.5% of the first deposit amount.',
                        fontSize: 12.sp,
                        color: theme == ThemeMode.light
                            ? Colors.black54
                            : Palette.secondaryBackgroundColor.withOpacity(0.6),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(40),
            MaterialButton(
              onPressed: () async {
                await Share.share(
                  'Get Viral Vibes now and receive up to 20% bonus on your First deposit by using my referral code during registration: ${user.referalCode}. Terms and conditions apply.',
                );
              },
              color: Palette.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: MediaQuery.sizeOf(context).width,
              height: 40.h,
              child: nunitoTextWidget('Share Referral Code',
                  color: Palette.primaryBackgroundColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
