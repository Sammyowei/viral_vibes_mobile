import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/authentication_manager_provider.dart';
import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_data_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/services/auth_state_client.dart';

import 'package:viral_vibes_mobile/src/services/network/_network_exception.dart';
import 'package:viral_vibes_mobile/src/services/network/network.dart';
import 'package:viral_vibes_mobile/src/src.dart';

import 'package:viral_vibes_mobile/src/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/providers.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late TextEditingController pin1;
  late TextEditingController pin2;
  late TextEditingController pin3;
  late TextEditingController pin4;
  late TextEditingController pin5;
  late AuthenticationManager _authenticationManager;
  late CountDownTimerNotifier notifier;

  final netClient = NetworkClient('https://api.viralvibes.hawkitpro.com');

  Future<void> getOtp(String id) async {
    final endpoint = 'api/auth/otp/generate?email=$id';

    final response = await netClient.getRequest(endpoint);

    print(response.body);
  }

  @override
  void initState() {
    pin1 = TextEditingController();
    pin2 = TextEditingController();
    pin3 = TextEditingController();
    pin4 = TextEditingController();
    pin5 = TextEditingController();

    ref.read(otpCountDownTimeStateNotifierProvider.notifier).startTimer();
    final user = ref.read(userDataProvider);
    getOtp(user.emailAddress);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _authenticationManager = ref.watch(authenticationManagerProvider);
    notifier = ref.read(otpCountDownTimeStateNotifierProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> verifyOtp(String otp) async {
      final user = ref.read(userDataProvider);

      final email = user.emailAddress;

      print(email);

      final endpoint = 'api/auth/verify?email=$email&otp=$otp';

      try {
        final response = await netClient.getRequest(endpoint);

        final body = jsonDecode(response.body);

        final cacheduser = CachedUserIdentifier();

        final id = await cacheduser.getUserId();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: nunitoTextWidget(
                '${body['message']}',
                fontSize: 14.sp,
                color: Palette.primaryBackgroundColor,
              ),
              backgroundColor: Palette.successColor,
            ),
          );

          final identifier = ref.read(userProvider);

          identifier.identifier = id;

          _authenticationManager.enableBiometrics();
          GoRouter.of(context).goNamed(RouteName.dashboard);
        }

        return;
      } on NetworkException catch (err) {
        final message = err.message;

        final startIndex = message.indexOf('{');
        final endIndex = message.lastIndexOf('}');

        final bodySubSring = message.substring(startIndex, endIndex + 1);

        String validJson = bodySubSring.replaceAllMapped(
          RegExp(r'(\w+)\s*:\s*([^,}]+)'),
          (Match match) => '"${match.group(1)}": "${match.group(2)}"',
        );

        final jsonData = jsonDecode(validJson);

        final error = jsonData['error'];

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: nunitoTextWidget(
                '$error',
                fontSize: 14.sp,
                color: Palette.primaryBackgroundColor,
              ),
              backgroundColor: Palette.errorColor,
            ),
          );
        }

        return;
      }
    }

    return Consumer(builder: (_, ref, __) {
      final theme = ref.watch(themeProvider);
      return Scaffold(
        backgroundColor: (theme == ThemeMode.light)
            ? Palette.secondaryBackgroundColor
            : Palette.darkthemeContainerColor,
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              nunitoTextWidget(
                'Enter Verification code',
                color:
                    (theme == ThemeMode.light) ? Colors.black87 : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
              ),
              nunitoTextWidget(
                'Enter the 5 digit code we just sent to  your email address.',
                color: (theme == ThemeMode.light)
                    ? Colors.black87
                    : Colors.white70,
                fontSize: 12.sp,
              ),
              Gap(10.h),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textfield(
                      (value) {
                        if (value.isNotEmpty &&
                            pin2.text.isNotEmpty &&
                            pin3.text.isNotEmpty &&
                            pin4.text.isNotEmpty &&
                            pin5.text.isNotEmpty) {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isTrue();
                        } else {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isFalse();
                        }
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: pin1,
                    ),
                    textfield(
                      (value) {
                        if (value.isNotEmpty &&
                            pin1.text.isNotEmpty &&
                            pin3.text.isNotEmpty &&
                            pin4.text.isNotEmpty &&
                            pin5.text.isNotEmpty) {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isTrue();
                        } else {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isFalse();
                        }
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: pin2,
                    ),
                    textfield(
                      (value) {
                        if (value.isNotEmpty &&
                            pin2.text.isNotEmpty &&
                            pin1.text.isNotEmpty &&
                            pin4.text.isNotEmpty &&
                            pin5.text.isNotEmpty) {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isTrue();
                        } else {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isFalse();
                        }
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: pin3,
                    ),
                    textfield(
                      (value) {
                        if (value.isNotEmpty &&
                            pin2.text.isNotEmpty &&
                            pin3.text.isNotEmpty &&
                            pin1.text.isNotEmpty &&
                            pin5.text.isNotEmpty) {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isTrue();
                        } else {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isFalse();
                        }
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: pin4,
                    ),
                    textfield(
                      (value) {
                        if (value.isNotEmpty &&
                            pin2.text.isNotEmpty &&
                            pin3.text.isNotEmpty &&
                            pin4.text.isNotEmpty &&
                            pin1.text.isNotEmpty) {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isTrue();
                        } else {
                          ref
                              .read(
                                  otpFormStateCompleteNotifierProvider.notifier)
                              .isFalse();
                        }
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      controller: pin5,
                    )
                  ],
                ),
              ),
              Gap(9.h),
              Row(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final timerNotifier = ref.watch(
                          otpCountDownTimeStateNotifierProvider.notifier);
                      final timer =
                          ref.watch<int>(otpCountDownTimeStateNotifierProvider);
                      return GestureDetector(
                        onTap: () async {
                          // TODO: Fix this up to generate and resend the otp
                          if (timer == 0) {
                            final user = ref.read(userDataProvider);
                            await getOtp(user.emailAddress);
                            timerNotifier.resetTimer(30);
                            timerNotifier.startTimer();
                          }
                        },
                        child: nunitoTextWidget(
                          'Resend code',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: (timer == 0)
                              ? Palette.tetiaryColor
                              : (theme == ThemeMode.light)
                                  ? Colors.black38
                                  : Colors.white70,
                        ),
                      );
                    },
                  ),
                  Gap(5.h),
                  Consumer(
                    builder: (context, ref, child) {
                      final timer =
                          ref.watch(otpCountDownTimeStateNotifierProvider);

                      return (timer == 0)
                          ? const SizedBox()
                          : nunitoTextWidget(
                              '$timer',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: (theme == ThemeMode.light)
                                  ? Colors.black38
                                  : Colors.white70,
                            );
                    },
                  ),
                ],
              ),
              Gap(40.h),
              Center(
                child: Consumer(
                  builder: (context, ref, child) {
                    final isValid =
                        ref.watch<bool>(otpFormStateCompleteNotifierProvider);
                    return MaterialButton(
                      onPressed: (isValid == true)
                          ? () async {
                              final otpPin = pin1.text +
                                  pin2.text +
                                  pin3.text +
                                  pin4.text +
                                  pin5.text;
                              print(otpPin);
                              await verifyOtp(otpPin);
                            }
                          : null,
                      disabledColor: Palette.tetiaryColor.withOpacity(0.3),
                      color: Palette.tetiaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                      minWidth: (MediaQuery.sizeOf(context).width * 0.6).w,
                      height: 40.h,
                      child: nunitoTextWidget(
                        'Verify and Continue',
                        color: Palette.primaryBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }
}

Widget textfield(void Function(String value) onChangeEvent,
    {TextEditingController? controller}) {
  return Consumer(builder: (context, ref, __) {
    final theme = ref.watch(themeProvider);
    return SizedBox(
      height: 50.h,
      width: 46.w,
      child: TextField(
        onChanged: onChangeEvent,
        controller: controller,
        decoration: InputDecoration(
          fillColor: (theme == ThemeMode.light)
              ? Palette.primaryBackgroundColor
              : Palette.dartThemeBAckgoundColor.withOpacity(0.01),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.primaryBackgroundColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(10).r,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.primaryBackgroundColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(10).r,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.primaryBackgroundColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(10).r,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Palette.primaryBackgroundColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(10).r,
          ),
          contentPadding: const EdgeInsets.all(10).r,
        ),
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w500,
          fontSize: 25.sp,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorColor: Palette.tetiaryColor,
        cursorHeight: 20,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  });
}
