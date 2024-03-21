import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/screens/home/market_place_screen.dart';
import 'package:viral_vibes_mobile/src/screens/home/personal_information_screen.dart';
import 'package:viral_vibes_mobile/src/screens/home/referal_screen.dart';
import 'package:viral_vibes_mobile/src/screens/home/service_category_list_scren.dart';
import 'package:viral_vibes_mobile/src/screens/home/service_order_page.dart';
import 'package:viral_vibes_mobile/src/screens/home/support_live_chat.dart';
import 'package:viral_vibes_mobile/src/screens/home/support_page.dart';
import 'package:viral_vibes_mobile/src/screens/payment/payment_detail_screen.dart';
import 'package:viral_vibes_mobile/src/screens/payment/payment_screen.dart';
import 'package:viral_vibes_mobile/src/src.dart';

import '../screens/home/service_category_page.dart';

final routes = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: RouteName.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
      routes: [
        GoRoute(
          path: 'onboarding',
          name: RouteName.onboarding,
          builder: (context, state) {
            return const OnboardingScreen();
          },
        ),
        GoRoute(
          path: 'auth',
          name: RouteName.authentication,
          builder: (context, state) {
            return const AuthScreen();
          },
          routes: [
            GoRoute(
              path: 'login',
              name: RouteName.login,
              builder: (context, state) {
                return const LoginScreen();
              },
            ),
            GoRoute(
              path: 'register',
              name: RouteName.register,
              builder: (context, state) {
                return const RegisterScreen();
              },
            ),
            GoRoute(
              path: 'otp-verification',
              name: RouteName.otpVerification,
              builder: (context, state) {
                return const OtpScreen();
              },
            )
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/dashboard',
      name: RouteName.dashboard,
      builder: (context, state) {
        return const DashBoardScreen();
      },
      routes: [
        GoRoute(
          path: 'payment',
          name: RouteName.paymentScreen,
          builder: (context, state) {
            return const PaymentScreen();
          },
          routes: [
            GoRoute(
              path: 'initialise',
              name: RouteName.paymentDetailScreen,
              builder: (context, state) {
                return const PaymentDetailScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'notification',
          name: RouteName.notifications,
          builder: (context, state) {
            return const NotificationScreen();
          },
        ),
        GoRoute(
            path: 'service',
            name: RouteName.service,
            builder: (context, state) {
              return const ServiceScreen();
            },
            routes: [
              GoRoute(
                path: 'category',
                name: RouteName.serviceCategory,
                builder: (context, state) {
                  final param = state.uri.queryParameters;

                  final serviceName = param['serviceName'];
                  print(serviceName);
                  return SeviceCategoriesScreen(
                    serviceName: serviceName,
                  );
                },
                routes: [
                  GoRoute(
                      path: 'serviceList',
                      name: RouteName.serviceCategoryList,
                      builder: (context, state) {
                        final param = state.uri.queryParameters;

                        final categoryListName = param['categoryListName'];
                        return ServiceCategoryListScreen(
                          serviceCategoryName: categoryListName,
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'order-service',
                          name: RouteName.serviceOrderPage,
                          builder: (context, state) {
                            final param = state.uri.queryParameters;

                            final serviceID = param['serviceId'];

                            print(serviceID);
                            return ServiceOrderPage(
                              serviceID: serviceID,
                            );
                          },
                        )
                      ])
                ],
              )
            ]),
        GoRoute(
          path: 'referral',
          name: RouteName.referral,
          builder: (context, state) {
            return const ReferalScreen();
          },
        ),
        GoRoute(
          path: 'personal-info',
          name: RouteName.personalInfo,
          builder: (context, state) {
            return const PersonalInfoScreen();
          },
        ),
        GoRoute(
          path: 'marketplace',
          name: RouteName.marketplace,
          builder: (context, state) {
            return const MarketplaceScreen();
          },
        ),
        GoRoute(
          path: 'support',
          name: RouteName.supportPage,
          builder: (context, state) {
            return const SupportPage();
          },
          routes: [
            GoRoute(
              path: 'livechat',
              name: RouteName.supportHelpDesk,
              builder: (context, state) {
                return const SupportLiveChatScreen();
              },
            )
          ],
        ),
      ],
    ),
  ],
);

GlobalKey<NavigatorState> navigatorKey = GlobalKey();
