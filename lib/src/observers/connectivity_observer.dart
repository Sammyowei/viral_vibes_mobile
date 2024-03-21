import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/connectivity_provider.dart';
import 'package:viral_vibes_mobile/src/providers/navigation_state_provider.dart';
import 'package:viral_vibes_mobile/src/src.dart';
import 'package:viral_vibes_mobile/src/widgets/nunito_text_widget.dart';

class ConnectivityObserver extends ConsumerWidget {
  final Widget Function(BuildContext context, bool isConnected) builder;

  const ConnectivityObserver({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<NavigatorState> navigatorState = GlobalKey();

    return Consumer(builder: (context, ref, _) {
      final connectivityState = ref.watch(connectivityProvider);

      final scaffoldMessengerKey = ref.watch(scaffoldMessangerStateProvider);
      return Scaffold(
        primary: true,
        key: scaffoldMessengerKey,
        body: builder(
          context,
          connectivityState.maybeWhen(
            data: (data) {
              final isConnected = data != ConnectivityResult.none;

              print(isConnected);

              print(data);

              return isConnected;
            },
            orElse: () => false,
            error: (error, stackTrace) => false,
          ),
        ),
      );
    });
  }
}
