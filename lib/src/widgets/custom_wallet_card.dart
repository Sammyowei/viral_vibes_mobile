import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:viral_vibes_mobile/src/models/user_model.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';

import '../src.dart';

Widget walletCard(BuildContext context, Size size, {required User user}) {
  final amount =
      NumberFormat.currency(decimalDigits: 2, name: 'Naira', symbol: "₦")
          .format(user.walletBalance);
  return SizedBox(
    width: size.width,
    height: 200.h,
    child: Stack(
      children: [
        Align(
          alignment: const Alignment(0, 0.94),
          child: Container(
            height: 15.h,
            width: size.width * 0.8,
            decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              color: Palette.cardColor.withOpacity(0.8),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 180.h,
            width: size.width * 0.9,
            padding: const EdgeInsets.all(8.5),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [
                  Palette.cardColor,
                  Palette.cardColor.withOpacity(0.9),
                  Palette.cardColor.withOpacity(0.8),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.decal,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 25.h,
                      width: 45.w,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Palette.alternateTertiary.withOpacity(0.5),
                      ),
                      child: Center(
                        child: nunitoTextWidget(
                          'NGN',
                          color: Palette.primaryBackgroundColor,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          nunitoTextWidget('Wallet Balance',
                              fontSize: 12.sp,
                              color: Palette.primaryBackgroundColor,
                              fontWeight: FontWeight.bold),
                          nunitoTextWidget(
                            amount,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Palette.primaryBackgroundColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed(RouteName.paymentScreen);
                      },
                      child: Container(
                        height: 45.h,
                        width: size.width * 0.4,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Palette.primaryBackgroundColor,
                            ),
                          ),
                          color: Palette.alternateTertiary.withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              IconProvider.wallet,
                              height: 20.h,
                              color: Palette.primaryBackgroundColor,
                            ),
                            Gap(5),
                            nunitoTextWidget(
                              'Add Naira',
                              fontSize: 14.sp,
                              color: Palette.primaryBackgroundColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 45.h,
                      width: size.width * 0.4,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Palette.primaryBackgroundColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Palette.alternateTertiary.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            IconProvider.wallet,
                            height: 20.h,
                            color: Palette.primaryBackgroundColor,
                          ),
                          Gap(5),
                          nunitoTextWidget(
                            'Add Others',
                            fontSize: 14.sp,
                            color: Palette.primaryBackgroundColor,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
