import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/models/user_model.dart';
import 'package:viral_vibes_mobile/src/providers/loading_indicator.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_data_provider.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/services/auth_state_client.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/utils/user_auth/user_auth_client.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

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
  late TextEditingController _referalCodeController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _userNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _referalCodeController = TextEditingController();
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
    return Consumer(builder: (_, ref, __) {
      final theme = ref.watch<ThemeMode>(themeProvider);
      return Scaffold(
        backgroundColor: (theme == ThemeMode.light)
            ? Palette.secondaryBackgroundColor
            : Palette.darkthemeContainerColor,
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ).r,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nunitoTextWidget(
                  'Register',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: (theme == ThemeMode.light)
                      ? Colors.black87
                      : Colors.white,
                ),
                Gap(10.h),
                nunitoTextWidget(
                  "Welcome, future Viber! Join the ride and ignite the buzz. Let's go viral, baby! 🚀🌟",
                  fontWeight: FontWeight.normal,
                  fontSize: 13.sp,
                  textAlign: TextAlign.start,
                  color: (theme == ThemeMode.light)
                      ? Colors.black54
                      : Colors.white70,
                ),
                Gap(20.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Email address ",
                        style: GoogleFonts.nunito(
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
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
                    color: (theme == ThemeMode.light)
                        ? Palette.primaryBackgroundColor
                        : Palette.primaryBackgroundColor.withOpacity(0.1),
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
                            .read(
                                loginAuthStateCompleteNotifierProvider.notifier)
                            .hide();
                      } else {
                        ref
                            .read(
                                loginAuthStateCompleteNotifierProvider.notifier)
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
                          color: (theme == ThemeMode.light)
                              ? Colors.black38
                              : Colors.white38,
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.nunito(
                      color: (theme == ThemeMode.light)
                          ? Colors.black87
                          : Colors.white,
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
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
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
                    color: (theme == ThemeMode.light)
                        ? Palette.primaryBackgroundColor
                        : Palette.primaryBackgroundColor.withOpacity(0.1),
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
                            .read(
                                loginAuthStateCompleteNotifierProvider.notifier)
                            .hide();
                      } else {
                        ref
                            .read(
                                loginAuthStateCompleteNotifierProvider.notifier)
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
                          color: (theme == ThemeMode.light)
                              ? Colors.black38
                              : Colors.white38,
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.nunito(
                      color: (theme == ThemeMode.light)
                          ? Colors.black87
                          : Colors.white,
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
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
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
                    color: (theme == ThemeMode.light)
                        ? Palette.primaryBackgroundColor
                        : Palette.primaryBackgroundColor.withOpacity(0.1),
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
                            .read(
                                loginAuthStateCompleteNotifierProvider.notifier)
                            .hide();
                      } else {
                        ref
                            .read(
                                loginAuthStateCompleteNotifierProvider.notifier)
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
                          color: (theme == ThemeMode.light)
                              ? Colors.black38
                              : Colors.white38,
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.nunito(
                      color: (theme == ThemeMode.light)
                          ? Colors.black87
                          : Colors.white,
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
                        text: "Referal Code ",
                        style: GoogleFonts.nunito(
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "(Optional)",
                        style: GoogleFonts.nunito(
                          color:
                              Palette.secondaryBackgroundColor.withOpacity(0.5),
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
                    color: (theme == ThemeMode.light)
                        ? Palette.primaryBackgroundColor
                        : Palette.primaryBackgroundColor.withOpacity(0.1),
                  ),
                  child: TextFormField(
                    controller: _referalCodeController,
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
                          color: (theme == ThemeMode.light)
                              ? Colors.black38
                              : Colors.white38,
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.nunito(
                      color: (theme == ThemeMode.light)
                          ? Colors.black87
                          : Colors.white,
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
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
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
                    color: (theme == ThemeMode.light)
                        ? Palette.primaryBackgroundColor
                        : Palette.primaryBackgroundColor.withOpacity(0.1),
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final isObscrued = ref
                          .watch<bool>(passwordObscuringTextNotifierProvider);
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
                              color: (theme == ThemeMode.light)
                                  ? Colors.black38
                                  : Colors.white38,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.only(top: 14, bottom: 14).r,
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
                                child: !isObscrued
                                    ? Image.asset(
                                        IconProvider.hide,
                                        height: 5.h,
                                        width: 5.w,
                                        color: (theme == ThemeMode.light)
                                            ? Colors.black38
                                            : Colors.white38,
                                      )
                                    : Image.asset(
                                        IconProvider.seen,
                                        height: 5.h,
                                        width: 5.w,
                                        color: (theme == ThemeMode.light)
                                            ? Colors.black38
                                            : Colors.white38,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        keyboardType: TextInputType.visiblePassword,
                        style: GoogleFonts.nunito(
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
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
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
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
                    color: (theme == ThemeMode.light)
                        ? Palette.primaryBackgroundColor
                        : Palette.primaryBackgroundColor.withOpacity(0.1),
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final isObscrued = ref.watch<bool>(
                          confirmPasswordObscuringTextNotifierProvider);
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
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 14,
                            ).r,
                            child: Image.asset(
                              IconProvider.password,
                              height: 5,
                              width: 5,
                              color: (theme == ThemeMode.light)
                                  ? Colors.black38
                                  : Colors.white38,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.only(top: 14, bottom: 14).r,
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(
                                        confirmPasswordObscuringTextNotifierProvider
                                            .notifier)
                                    .tuggle();
                              },
                              child: SizedBox(
                                height: 10.h,
                                width: 10.w,
                                child: !isObscrued
                                    ? Image.asset(
                                        IconProvider.hide,
                                        height: 5.h,
                                        width: 5.w,
                                        color: (theme == ThemeMode.light)
                                            ? Colors.black38
                                            : Colors.white38,
                                      )
                                    : Image.asset(
                                        IconProvider.seen,
                                        height: 5.h,
                                        width: 5.w,
                                        color: (theme == ThemeMode.light)
                                            ? Colors.black38
                                            : Colors.white38,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        keyboardType: TextInputType.visiblePassword,
                        style: GoogleFonts.nunito(
                          color: (theme == ThemeMode.light)
                              ? Colors.black87
                              : Colors.white,
                        ),
                        cursorColor: Palette.tetiaryColor,
                        cursorHeight: 15.h,
                      );
                    },
                  ),
                ),
                Gap(10),
                Gap(20),
                Center(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final loadingIndicator =
                          ref.watch(loadingIndicatorProvider);
                      final isValid = ref
                          .watch<bool>(signUpAuthStateCompleteNotifierProvider);
                      return MaterialButton(
                        onPressed: (isValid == true)
                            ? () async {
                                ref
                                    .read(loadingIndicatorProvider.notifier)
                                    .isLoading();
                                final auth = Authentication();

                                final response = await auth.createUser(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  mobileNumber: _phoneNumberController.text
                                    ..trim(),
                                  userName: _userNameController.text.trim(),
                                  referalcode:
                                      _referalCodeController.text.isEmpty
                                          ? null
                                          : _referalCodeController.text.trim(),
                                );

                                if (response!.containsKey('error')) {
                                  final errorMessage = response['error'];
                                  ref
                                      .read(loadingIndicatorProvider.notifier)
                                      .finishedloading();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: nunitoTextWidget(
                                          '$errorMessage',
                                          fontSize: 14.sp,
                                          color: Palette.primaryBackgroundColor,
                                        ),
                                        backgroundColor: Palette.errorColor,
                                      ),
                                    );
                                  }

                                  return;
                                } else {
                                  final message = response['message'];

                                  final detail = response['detail'];

                                  final userData = User.fromJson(detail);

                                  final cached = CachedUserIdentifier();

                                  await cached.setUser(userData.emailAddress);

                                  ref
                                      .read(loadingIndicatorProvider.notifier)
                                      .finishedloading();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: nunitoTextWidget(
                                          '$message',
                                          fontSize: 14.sp,
                                          color: Palette.primaryBackgroundColor,
                                        ),
                                        backgroundColor: Palette.successColor,
                                      ),
                                    );

                                    final user = ref.read(dataGetterProvider);

                                    user.userData = detail;

                                    GoRouter.of(context)
                                        .goNamed(RouteName.otpVerification);
                                  }
                                }
                              }
                            : null,
                        disabledColor: Palette.tetiaryColor.withOpacity(0.3),
                        color: Palette.tetiaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20).h,
                        ),
                        minWidth: (MediaQuery.sizeOf(context).width * 0.7),
                        height: 45.h,
                        child: loadingIndicator
                            ? const CircularProgressIndicator.adaptive()
                            : nunitoTextWidget(
                                'Register',
                                color: Palette.primaryBackgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                      );
                    },
                  ),
                ),
                Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    nunitoTextWidget(
                      "Already have an account? ",
                      color: (theme == ThemeMode.light)
                          ? Colors.black87
                          : Colors.white,
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
                Gap(40)
              ],
            ),
          ),
        ),
      );
    });
  }
}
