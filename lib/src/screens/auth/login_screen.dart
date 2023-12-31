import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:viral_vibes_mobile/src/assets_provider/icons_provider.dart';
import 'package:viral_vibes_mobile/src/providers/providers.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondaryBackgroundColor,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nunitoTextWidget(
                'Login',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              Gap(10.h),
              nunitoTextWidget(
                "Welcome back, Viber! Ready to reignite and amplify? Let's go viral, baby! 🌟🔥",
                fontWeight: FontWeight.normal,
                fontSize: 13.sp,
                textAlign: TextAlign.start,
                color: Colors.black54,
              ),
              Gap(20.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Email address ",
                      style: GoogleFonts.nunito(
                        color: Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "*",
                      style: GoogleFonts.nunito(
                        color: Palette.errorColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20).h,
                  ),
                  color: Palette.primaryBackgroundColor,
                ),
                child: TextFormField(
                  controller: _emailController,
                  onChanged: (value) {
                    if (value.length > 5 &&
                        _passwordController.text.length >= 8) {
                      ref
                          .read(loginAuthStateCompleteNotifierProvider.notifier)
                          .hide();
                    } else {
                      ref
                          .read(loginAuthStateCompleteNotifierProvider.notifier)
                          .show();
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                    ).h,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        top: 14,
                        bottom: 14,
                      ).h,
                      child: Image.asset(
                        IconProvider.user,
                        height: 5.h,
                        width: 5.w,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.nunito(
                    color: Colors.black87,
                  ),
                  cursorColor: Palette.tetiaryColor,
                  cursorHeight: 15.h,
                ),
              ),
              Gap(10.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Password ",
                      style: GoogleFonts.nunito(
                        color: Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "*",
                      style: GoogleFonts.nunito(
                        color: Palette.errorColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20).r,
                  ),
                  color: Palette.primaryBackgroundColor,
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    final isObscrued =
                        ref.watch<bool>(passwordObscuringTextNotifierProvider);
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: isObscrued,
                      onChanged: (value) {
                        if (value.length >= 8 &&
                            _emailController.text.length > 5) {
                          ref
                              .read(loginAuthStateCompleteNotifierProvider
                                  .notifier)
                              .hide();
                        } else {
                          ref
                              .read(loginAuthStateCompleteNotifierProvider
                                  .notifier)
                              .show();
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                        ).h,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 14,
                            bottom: 14,
                          ).h,
                          child: Image.asset(
                            IconProvider.password,
                            height: 5.h,
                            width: 5.w,
                            color: Colors.black38,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 14).h,
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(passwordObscuringTextNotifierProvider
                                      .notifier)
                                  .tuggle();
                            },
                            child: SizedBox(
                              height: 10.h,
                              width: 10.w,
                              child: isObscrued
                                  ? Image.asset(
                                      IconProvider.seen,
                                      height: 5.h,
                                      width: 5.w,
                                      color: Colors.black38,
                                    )
                                  : Image.asset(
                                      IconProvider.hide,
                                      height: 5.h,
                                      width: 5.w,
                                      color: Colors.black38,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      keyboardType: TextInputType.visiblePassword,
                      style: GoogleFonts.nunito(
                        color: Colors.black87,
                      ),
                      cursorColor: Palette.tetiaryColor,
                      cursorHeight: 15.h,
                    );
                  },
                ),
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {},
                child: nunitoTextWidget(
                  'Forgot your password?',
                  fontSize: 13.sp,
                  color: Palette.tetiaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(20.h),
              Center(
                child: Consumer(
                  builder: (context, ref, child) {
                    final isValid =
                        ref.watch<bool>(loginAuthStateCompleteNotifierProvider);
                    return MaterialButton(
                      onPressed: (isValid == true)
                          ? () {
                              context.pushNamed(RouteName.otpVerification);
                            }
                          : null,
                      disabledColor: Palette.tetiaryColor.withOpacity(0.3),
                      color: Palette.tetiaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                      minWidth: (MediaQuery.sizeOf(context).width * 0.7).w,
                      height: 35.h,
                      child: nunitoTextWidget(
                        'Login',
                        color: Palette.primaryBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    );
                  },
                ),
              ),
              Gap(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  nunitoTextWidget(
                    "Don't have an account? ",
                    color: Colors.black45,
                    fontSize: 14.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).goNamed(RouteName.register);
                    },
                    child: nunitoTextWidget(
                      "Register.",
                      color: Palette.tetiaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
