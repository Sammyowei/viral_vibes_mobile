import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
            height: MediaQuery.sizeOf(context).height * 0.65,
            width: MediaQuery.sizeOf(context).width,
            decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(img.ImageProvider.authScreenImg),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: MediaQuery.sizeOf(context).width,
              decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ),
                    topRight: Radius.circular(
                      30,
                    ),
                  ),
                ),
                color: Palette.primaryBackgroundColor,
              ),
              child: Column(
                children: [
                  const Gap(20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Let's go Viral\n",
                          style: GoogleFonts.nunito(
                            color: Colors.black87,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "Together.",
                          style: GoogleFonts.nunito(
                            color: Palette.tetiaryColor,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: nunitoTextWidget(
                      "Leave your product and content for us and we will let the world know about it.",
                      fontSize: 13,
                      textAlign: TextAlign.center,
                      color: Colors.black45,
                    ),
                  ),
                  const Gap(70),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(RouteName.login);
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Palette.tetiaryColor, width: 2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: nunitoTextWidget(
                                'Login',
                                color: Palette.tetiaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(RouteName.register);
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Palette.tetiaryColor,
                            ),
                            child: Center(
                              child: nunitoTextWidget(
                                'Register',
                                color: Palette.primaryBackgroundColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
