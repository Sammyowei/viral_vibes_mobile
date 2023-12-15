import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/assets_provider/icons_provider.dart';
import 'package:viral_vibes_mobile/src/providers/providers.dart';
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nunitoTextWidget(
              'Login',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            const Gap(10),
            nunitoTextWidget(
              "Welcome back, Viber! Ready to reignite and amplify? Let's go viral, baby! 🌟🔥",
              fontWeight: FontWeight.normal,
              fontSize: 13,
              textAlign: TextAlign.start,
              color: Colors.black54,
            ),
            const Gap(20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Email address ",
                    style: GoogleFonts.nunito(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "*",
                    style: GoogleFonts.nunito(
                      color: Palette.errorColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Palette.primaryBackgroundColor,
              ),
              child: TextFormField(
                controller: _emailController,
                onChanged: (value) {
                  if (value.length > 5 &&
                      _passwordController.text.length >= 8) {
                    ref.read(authStateCompleteNotifierProvider.notifier).hide();
                  } else {
                    ref.read(authStateCompleteNotifierProvider.notifier).show();
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
                    ),
                    child: Image.asset(
                      IconProvider.user,
                      height: 5,
                      width: 5,
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
                cursorHeight: 15,
              ),
            ),
            const Gap(20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Password ",
                    style: GoogleFonts.nunito(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "*",
                    style: GoogleFonts.nunito(
                      color: Palette.errorColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
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
                            .read(authStateCompleteNotifierProvider.notifier)
                            .hide();
                      } else {
                        ref
                            .read(authStateCompleteNotifierProvider.notifier)
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
                        ),
                        child: Image.asset(
                          IconProvider.password,
                          height: 5,
                          width: 5,
                          color: Colors.black38,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 14),
                        child: GestureDetector(
                          onTap: () {
                            ref
                                .read(passwordObscuringTextNotifierProvider
                                    .notifier)
                                .tuggle();
                          },
                          child: SizedBox(
                            height: 10,
                            width: 10,
                            child: isObscrued
                                ? Image.asset(
                                    IconProvider.seen,
                                    height: 5,
                                    width: 5,
                                    color: Colors.black38,
                                  )
                                : Image.asset(
                                    IconProvider.hide,
                                    height: 5,
                                    width: 5,
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
                    cursorHeight: 15,
                  );
                },
              ),
            ),
            const Gap(10),
            GestureDetector(
              onTap: () {},
              child: nunitoTextWidget(
                'Forgot your password?',
                fontSize: 13,
                color: Palette.tetiaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            Center(
              child: Consumer(
                builder: (context, ref, child) {
                  final isValid =
                      ref.watch<bool>(authStateCompleteNotifierProvider);
                  return MaterialButton(
                    onPressed: (isValid == true) ? () {} : null,
                    disabledColor: Palette.tetiaryColor.withOpacity(0.3),
                    color: Palette.tetiaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minWidth: MediaQuery.sizeOf(context).width * 0.7,
                    height: 40,
                    child: nunitoTextWidget(
                      'Login',
                      color: Palette.primaryBackgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                },
              ),
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nunitoTextWidget(
                  "Don't have an account? ",
                  color: Colors.black45,
                  fontSize: 14,
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to register endpoint
                  },
                  child: nunitoTextWidget(
                    "Register.",
                    color: Palette.tetiaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
