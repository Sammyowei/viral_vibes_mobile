import 'dart:io';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:viral_vibes_mobile/src/models/user_model.dart';
import 'package:viral_vibes_mobile/src/providers/authentication_manager_provider.dart';
import 'package:viral_vibes_mobile/src/providers/loading_indicator.dart';
import 'package:viral_vibes_mobile/src/providers/providers.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/services/auth_state_client.dart';
import 'package:viral_vibes_mobile/src/services/local_auth/local_auth.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/utils/user_auth/user_auth_client.dart';
import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late List<BiometricType> _availableBiometrics;
  late BiometricAuthenticationClient _biometricAuthenticationClient;
  late AuthenticationManager _authenticationManager;

  late bool _isBiometricAvailable;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _biometricAuthenticationClient = BiometricAuthenticationClient();

    checkBiometric();
    checkAvailableBiometrics();

    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        print(_availableBiometrics);
        print(_isBiometricAvailable);
      },
    );
  }

  @override
  void didChangeDependencies() {
    _authenticationManager = ref.watch(authenticationManagerProvider);

    super.didChangeDependencies();
  }

  void checkBiometric() async {
    _availableBiometrics =
        await _biometricAuthenticationClient.getAvailableBiometrics();
  }

  void checkAvailableBiometrics() async {
    _isBiometricAvailable =
        await _biometricAuthenticationClient.isBiometricAvailable();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
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
              top: 20,
            ).r,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nunitoTextWidget(
                    'Login',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: (theme == ThemeMode.light)
                        ? Colors.black87
                        : Colors.white,
                  ),
                  Gap(10),
                  nunitoTextWidget(
                    "Welcome back, Viber! Ready to reignite and amplify? Let's go viral, baby! 🌟🔥",
                    fontWeight: FontWeight.normal,
                    fontSize: 13.sp,
                    textAlign: TextAlign.start,
                    color: (theme == ThemeMode.light)
                        ? Colors.black54
                        : Colors.white70,
                  ),
                  Gap(20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Email address ",
                          style: GoogleFonts.nunito(
                            color: (theme == ThemeMode.light)
                                ? Colors.black87
                                : Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "*",
                          style: GoogleFonts.nunito(
                            color: Palette.errorColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                      color: (theme == ThemeMode.light)
                          ? Palette.primaryBackgroundColor
                          : Palette.primaryBackgroundColor.withOpacity(0.1),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: _emailController,
                        onChanged: (value) {
                          if (value.length > 5 &&
                              _passwordController.text.length >= 8) {
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
                              IconProvider.user,
                              height: 20.h,
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
                  ),
                  Gap(10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Password ",
                          style: GoogleFonts.nunito(
                            color: (theme == ThemeMode.light)
                                ? Colors.black87
                                : Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "*",
                          style: GoogleFonts.nunito(
                            color: Palette.errorColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45.h,
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
                        return Center(
                          child: TextFormField(
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
                              ).r,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  top: 14,
                                  bottom: 14,
                                ).r,
                                child: Image.asset(
                                  IconProvider.password,
                                  height: 20.h,
                                  color: (theme == ThemeMode.light)
                                      ? Colors.black38
                                      : Colors.white38,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 14)
                                        .r,
                                child: GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(
                                            passwordObscuringTextNotifierProvider
                                                .notifier)
                                        .tuggle();
                                  },
                                  child: SizedBox(
                                    height: 10.h,
                                    width: 10.w,
                                    child: isObscrued
                                        ? Image.asset(
                                            IconProvider.seen,
                                            height: 50.h,
                                            color: (theme == ThemeMode.light)
                                                ? Colors.black38
                                                : Colors.white38,
                                          )
                                        : Image.asset(
                                            IconProvider.hide,
                                            height: 50.h,
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
                          ),
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
                  Gap(20),
                  Center(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final isValid = ref.watch<bool>(
                            loginAuthStateCompleteNotifierProvider);

                        final loadingIndicator =
                            ref.watch(loadingIndicatorProvider);
                        return MaterialButton(
                            onPressed: (isValid == true)
                                ? () async {
                                    // Perform Authentication Logic

                                    final authentication = Authentication();
                                    ref
                                        .read(
                                            loginAuthStateCompleteNotifierProvider
                                                .notifier)
                                        .tuggle();
                                    ref
                                        .read(loadingIndicatorProvider.notifier)
                                        .tuggle();
                                    // Login the user
                                    final data = await authentication.loginUser(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim());
                                    ref
                                        .read(loadingIndicatorProvider.notifier)
                                        .tuggle();

                                    // Make the  button clickable
                                    ref
                                        .read(
                                            loginAuthStateCompleteNotifierProvider
                                                .notifier)
                                        .tuggle();
                                    //cheeck if the data has an error response

                                    print(data);
                                    if (data!.containsKey('error')) {
                                      final message = data['error'];

                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: nunitoTextWidget(
                                              '$message',
                                              color: Palette
                                                  .primaryBackgroundColor,
                                              fontSize: 14.sp,
                                            ),
                                            backgroundColor: Palette.errorColor,
                                          ),
                                        );
                                      }
                                    } else {
                                      final cachedUser = CachedUserIdentifier();

                                      await cachedUser.setUser(
                                        _emailController.text.trim(),
                                      );

                                      // Daa"

                                      if (context.mounted) {
//

                                        final detail = data['detail'];

                                        final user = User.fromJson(detail);

                                        final userp = ref.watch(userProvider);

                                        userp.identifier = user.emailAddress;

                                        print(user.isVerified);

                                        if (user.isVerified) {
                                          print("Verified USer");
                                          GoRouter.of(context)
                                              .goNamed(RouteName.dashboard);
                                        } else {
                                          GoRouter.of(context).goNamed(
                                              RouteName.otpVerification);
                                        }

                                        _authenticationManager
                                            .enableBiometrics();
                                        //

                                        final message = data['message'];
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: nunitoTextWidget(
                                              '$message',
                                              color: Palette
                                                  .primaryBackgroundColor,
                                              fontSize: 14.sp,
                                            ),
                                            backgroundColor:
                                                Palette.successColor,
                                          ),
                                        );
                                      }
                                    }
                                  }
                                : null,
                            disabledColor:
                                Palette.tetiaryColor.withOpacity(0.3),
                            color: Palette.tetiaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20).r,
                            ),
                            minWidth:
                                (MediaQuery.sizeOf(context).width * 0.7).w,
                            height: 40.h,
                            child: loadingIndicator == false
                                ? nunitoTextWidget(
                                    'Login',
                                    color: Palette.primaryBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  )
                                : CircularProgressIndicator(
                                    color: Palette.primaryBackgroundColor,
                                  ));
                      },
                    ),
                  ),
                  Gap(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      nunitoTextWidget(
                        "Don't have an account? ",
                        color: (theme == ThemeMode.light)
                            ? Colors.black87
                            : Colors.white,
                        fontSize: 13.sp,
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).goNamed(RouteName.register);
                        },
                        child: nunitoTextWidget(
                          "Register.",
                          color: Palette.tetiaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  const Gap(50),
                  Consumer(
                    builder: (context, ref, child) {
                      final biometricEnabled =
                          ref.watch(biometricEnabledProvider);
                      return biometricEnabled.when(
                        data: (data) {
                          if (data) {
                            return Consumer(
                              builder: (context, ref, child) {
                                final availableBiometric =
                                    ref.watch(availableBiometricProvider);

                                final biomertricClientProvider =
                                    ref.watch(biometricProvider);

                                return availableBiometric.when(
                                  data: (data) {
                                    if (data.isEmpty) {
                                      return Container();
                                    } else {
                                      return Center(
                                        child: biometricAuthWidget(
                                          context,
                                          ref,
                                          data: data,
                                          client: biomertricClientProvider,
                                        ),
                                      );
                                    }
                                  },
                                  error: (error, stackTrace) {
                                    return Container();
                                  },
                                  loading: () {
                                    return Container();
                                  },
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                        error: (error, stackTrace) {
                          return Container();
                        },
                        loading: () {
                          return Container();
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget biometricAuthWidget(BuildContext context, WidgetRef ref,
    {required List<BiometricType> data,
    required BiometricAuthenticationClient client}) {
  if (Platform.isAndroid) {
    if (data.contains(BiometricType.face)) {
      return biometricDataWidgets(
        context,
        ref,
        client: client,
        imagePath: IconProvider.faceIdIcon,
      );
    } else {
      return biometricDataWidgets(
        context,
        ref,
        client: client,
        imagePath: IconProvider.fingerPrintIcon,
      );
    }
  } else if (Platform.isIOS) {
    if (data.contains(BiometricType.face)) {
      return biometricDataWidgets(
        context,
        ref,
        client: client,
        imagePath: IconProvider.faceIdIcon,
      );
    } else {
      return biometricDataWidgets(
        context,
        ref,
        client: client,
        imagePath: IconProvider.fingerPrintIcon,
      );
    }
  } else {
    return Container();
  }
}

GestureDetector biometricDataWidgets(
  BuildContext context,
  WidgetRef ref, {
  required BiometricAuthenticationClient client,
  required String imagePath,
}) {
  return GestureDetector(
    onTap: () async {
      final biometricState = await client.authenticate();

      final cached = CachedUserIdentifier();

      final user = await cached.getUserId();
      if (biometricState is BiometricAuthenticated) {
        if (context.mounted) {
          final id = ref.read(userProvider);

          id.identifier = user;
          GoRouter.of(context).goNamed(RouteName.dashboard);
        }
      } else {
        print("Nah i aint letting you through.");
      }
    },
    child: Container(
      height: 70.h,
      width: 70.w,
      padding: const EdgeInsets.all(10).r,
      decoration: BoxDecoration(
        color: Palette.tetiaryColor.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          color: Palette.alternateTertiary,
        ),
      ),
    ),
  );
}
