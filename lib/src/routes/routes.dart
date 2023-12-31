import 'package:go_router/go_router.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';

final routes = GoRouter(
  // initialLocation: '/auth/otp-verification',
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
          ),
        ]),
  ],
);
