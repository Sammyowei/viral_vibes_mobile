import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/assets_provider/image_provider.dart'
    as img;

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: (MediaQuery.sizeOf(context).height * 0.7),
            width: (MediaQuery.sizeOf(context).width),
            decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(img.ImageProviders.authScreenImg),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Consumer(builder: (_, ref, ___) {
              final theme = ref.watch(themeProvider);
              return Container(
                height: (MediaQuery.sizeOf(context).height * 0.4),
                width: (MediaQuery.sizeOf(context).width),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        30,
                      ),
                      topRight: Radius.circular(
                        30,
                      ),
                    ).w,
                  ),
                  color: (theme == ThemeMode.light)
                      ? Palette.primaryBackgroundColor
                      : Palette.darkthemeContainerColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Gap(20.h),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Let's go Viral\n",
                            style: GoogleFonts.nunito(
                              color: (theme == ThemeMode.light)
                                  ? Colors.black87
                                  : Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Together.",
                            style: GoogleFonts.nunito(
                              color: Palette.tetiaryColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ).r,
                      child: nunitoTextWidget(
                        "Leave your product and content for us and we will let the world know about it.",
                        fontSize: 13.sp,
                        textAlign: TextAlign.center,
                        color: (theme == ThemeMode.light)
                            ? Colors.black87
                            : Colors.white60,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20).h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(RouteName.login);
                            },
                            child: Container(
                              height: 50.h,
                              width: (MediaQuery.sizeOf(context).width * 0.4),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Palette.tetiaryColor, width: 2.w),
                                  borderRadius: BorderRadius.circular(30).r,
                                ),
                              ),
                              child: Center(
                                child: nunitoTextWidget(
                                  'Login',
                                  color: Palette.tetiaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed(RouteName.register);
                            },
                            child: Container(
                              height: 50.h,
                              width: (MediaQuery.sizeOf(context).width * 0.4),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30).r,
                                ),
                                color: Palette.tetiaryColor,
                              ),
                              child: Center(
                                child: nunitoTextWidget(
                                  'Register',
                                  color: Palette.primaryBackgroundColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(50.h)
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
