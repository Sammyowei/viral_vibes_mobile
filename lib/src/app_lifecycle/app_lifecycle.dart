import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/app_lifecycle_notifler.dart';

class AppLifeCycleObserver extends ConsumerWidget {
  final Widget Function(BuildContext context, AppLifecycleState state) builder;
  const AppLifeCycleObserver({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final appLifecycleState = ref.watch(appLifecycleProvider);

        return builder(
          context,
          appLifecycleState,
        );
      },
    );
  }
}
