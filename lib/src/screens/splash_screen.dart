import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        GoRouter.of(context).pushReplacementNamed(RouteName.onboarding);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.tetiaryColor,
      body: Center(
          child: DefaultTextStyle(
        style: GoogleFonts.nunito(
          color: Palette.primaryBackgroundColor,
          fontSize: 45,
          fontWeight: FontWeight.bold,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            RotateAnimatedText(
              'Viral Vibes',
              rotateOut: false,
              textStyle: GoogleFonts.nunito(
                color: Palette.primaryBackgroundColor,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(seconds: 1),
            ),
          ],
          repeatForever: false,
          totalRepeatCount: 1,
          onTap: () {
            if (kDebugMode) {
              print("Tap Event");
            }
          },
        ),
      )),
    );
  }
}
