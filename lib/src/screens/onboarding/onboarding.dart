import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/providers.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/screens/onboarding/onboarding_one.dart';
import 'package:viral_vibes_mobile/src/screens/onboarding/onboarding_three.dart';
import 'package:viral_vibes_mobile/src/screens/onboarding/onboarding_two.dart';
import 'package:viral_vibes_mobile/src/src.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pages = <Widget>[
    const OnboardingOne(),
    const OnboardingTwo(),
    const OnboardingThree(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final size = MediaQuery.sizeOf(context);
                final containerWidth = size.width * 0.31;
                const containerheight = 6.0;

                final page = ref.watch<int>(onboardingStateProvider);
                final onPageColor = Palette.tetiaryColor;
                final pageIndicatorColor = Palette.alternateTertiary;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => ref
                            .read(onboardingStateProvider.notifier)
                            .pageAtIndex(0),
                        child: Container(
                          height: containerheight,
                          width: containerWidth,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: (page == 0 || page > 0)
                                ? onPageColor
                                : pageIndicatorColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => ref
                            .read(onboardingStateProvider.notifier)
                            .pageAtIndex(1),
                        child: Container(
                          height: containerheight,
                          width: containerWidth,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: (page == 1 || page > 1)
                                ? onPageColor
                                : pageIndicatorColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => ref
                            .read(onboardingStateProvider.notifier)
                            .pageAtIndex(2),
                        child: Container(
                          height: containerheight,
                          width: containerWidth,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: (page == 2 || page > 2)
                                ? onPageColor
                                : pageIndicatorColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch<int>(onboardingStateProvider);
                      return _pages[state];
                    },
                  ),
                  Align(
                    alignment: const Alignment(0, 0.5),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final state = ref.watch(onboardingStateProvider);
                              return (state != 0)
                                  ? GestureDetector(
                                      onTap: () => ref
                                          .read(
                                              onboardingStateProvider.notifier)
                                          .previous(),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          color: Palette.tetiaryColor,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.navigate_before_rounded,
                                            size: 35,
                                            color:
                                                Palette.primaryBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return GestureDetector(
                                onTap: () => ref
                                    .read(onboardingStateProvider.notifier)
                                    .next(_pages.length - 1),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Palette.tetiaryColor,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.navigate_next_rounded,
                                      size: 35,
                                      color: Palette.primaryBackgroundColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return Align(
                        alignment: const Alignment(0, 0.78),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: GestureDetector(
                            onTap: () => GoRouter.of(context)
                                .pushReplacementNamed(RouteName.authentication),
                            child: Container(
                              height: 50,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Palette.tetiaryColor,
                              ),
                              child: Center(
                                child: nunitoTextWidget('Get Started',
                                    color: Palette.primaryBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
