import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/authentication_manager_provider.dart';

import 'package:viral_vibes_mobile/src/providers/theme_provider_state_notifier_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
import 'package:viral_vibes_mobile/src/src.dart';

final container = ProviderContainer();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  container.refresh(serviceProvider.future).then((value) {
    final serviceList = container.read(serviceListProvider);

    serviceList.addAll(value);
  });

  container.refresh(biometricEnabledProvider.future);
  container.refresh(biometricEnabledProvider.future);
  runApp(UncontrolledProviderScope(
    container: container,
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeProviderNotifier = ref.watch(themeProvider.notifier);

    // Load saved theme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeProviderNotifier.loadTheme();
    });

    final _routes = routes;

    return AppLifeCycleObserver(
      builder: (ctx, state) {
        return ScreenUtilInit(
          ensureScreenSize: true,
          useInheritedMediaQuery: true,
          designSize: const Size(393.0, 852.0),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp.router(
              key: _navigatorKey,
              debugShowCheckedModeBanner: false,
              // debugShowMaterialGrid: true,

              title: 'Viral Vibes',
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: themeMode,
              // routeInformationParser: _routes.routeInformationParser,
              // routeInformationProvider: _routes.routeInformationProvider,
              // routerDelegate: _routes.routerDelegate,
              routerConfig: RouterConfig(
                routerDelegate: _routes.routerDelegate,
                routeInformationParser: _routes.routeInformationParser,
                routeInformationProvider: _routes.routeInformationProvider,
                backButtonDispatcher: RootBackButtonDispatcher(),
              ),
              scaffoldMessengerKey: _scaffoldMessengerKey,
            );
          },
        );
      },
    );
  }
}
