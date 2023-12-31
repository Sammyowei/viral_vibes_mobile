import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

import '../../assets_provider/icons_provider.dart';
import '../../providers/providers.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _userNameController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _userNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    _phoneNumberController.dispose();
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
                'Register',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              Gap(10.h),
              nunitoTextWidget(
                "Welcome, future Viber! Join the ride and ignite the buzz. Let's go viral, baby! 🚀🌟",
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
                    if (value.length >= 5 &&
                        _emailController.text.length > 5 &&
                        _userNameController.text.length > 5 &&
                        _phoneNumberController.text.length > 9 &&
                        _confirmPasswordController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _passwordController.text ==
                            _confirmPasswordController.text) {
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
                    ).r,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        top: 14,
                        bottom: 14,
                      ).r,
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
              Gap(20.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Username ",
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
                  controller: _userNameController,
                  onChanged: (value) {
                    if (value.length >= 5 &&
                        _emailController.text.length > 5 &&
                        _userNameController.text.length > 5 &&
                        _phoneNumberController.text.length > 9 &&
                        _confirmPasswordController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _passwordController.text ==
                            _confirmPasswordController.text) {
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
                    ).r,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        top: 14,
                        bottom: 14,
                      ).r,
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
              Gap(20.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Phone number ",
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
                child: TextFormField(
                  controller: _phoneNumberController,
                  onChanged: (value) {
                    if (value.length > 9 &&
                        _emailController.text.length > 5 &&
                        _userNameController.text.length > 5 &&
                        _phoneNumberController.text.length > 9 &&
                        _confirmPasswordController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _passwordController.text ==
                            _confirmPasswordController.text) {
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
                    ).r,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        top: 14,
                        bottom: 14,
                      ).r,
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
              Gap(20.h),
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
                            _emailController.text.length > 5 &&
                            _userNameController.text.length > 5 &&
                            _phoneNumberController.text.length > 9 &&
                            _confirmPasswordController.text.isNotEmpty &&
                            value.isNotEmpty &&
                            value == _confirmPasswordController.text) {
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
                        ).r,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 14,
                            bottom: 14,
                          ).r,
                          child: Image.asset(
                            IconProvider.password,
                            height: 5.h,
                            width: 5.w,
                            color: Colors.black38,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 14).r,
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
              Gap(20.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Confirm password ",
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
                      controller: _confirmPasswordController,
                      obscureText: isObscrued,
                      onChanged: (value) {
                        if (value.length >= 5 &&
                            _emailController.text.length > 5 &&
                            _userNameController.text.length > 5 &&
                            _phoneNumberController.text.length > 9 &&
                            value.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _passwordController.text == value) {
                          ref
                              .read(signUpAuthStateCompleteNotifierProvider
                                  .notifier)
                              .hide();
                        } else {
                          ref
                              .read(signUpAuthStateCompleteNotifierProvider
                                  .notifier)
                              .show();
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                        ).r,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 14,
                            bottom: 14,
                          ).r,
                          child: Image.asset(
                            IconProvider.password,
                            height: 5.h,
                            width: 5.w,
                            color: Colors.black38,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 14).r,
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
              Gap(20.h),
              Center(
                child: Consumer(
                  builder: (context, ref, child) {
                    final isValid = ref
                        .watch<bool>(signUpAuthStateCompleteNotifierProvider);
                    return MaterialButton(
                      onPressed: (isValid == true) ? () {} : null,
                      disabledColor: Palette.tetiaryColor.withOpacity(0.3),
                      color: Palette.tetiaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).h,
                      ),
                      minWidth: (MediaQuery.sizeOf(context).width * 0.7).w,
                      height: 40.h,
                      child: nunitoTextWidget(
                        'Register',
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
                    "Already have an account? ",
                    color: Colors.black45,
                    fontSize: 14.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).goNamed(RouteName.login);
                    },
                    child: nunitoTextWidget(
                      "Login.",
                      color: Palette.tetiaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Gap(40.h)
            ],
          ),
        ),
      ),
    );
  }
}
