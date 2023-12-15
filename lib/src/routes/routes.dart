import 'package:go_router/go_router.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';
import 'package:viral_vibes_mobile/src/src.dart';

final routes = GoRouter(
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
            )
          ],
        ),
      ],
    ),
  ],
);
