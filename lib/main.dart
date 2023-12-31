import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/src.dart';

Future<void> main() async {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return AppLifeCycleObserver(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Viral Vibes',
              theme: AppTheme.theme,
              routerConfig: RouterConfig(
                routerDelegate: routes.routerDelegate,
                routeInformationParser: routes.routeInformationParser,
                routeInformationProvider: routes.routeInformationProvider,
                backButtonDispatcher: RootBackButtonDispatcher(),
              ),
            );
          },
        );
      },
    );
  }
}
