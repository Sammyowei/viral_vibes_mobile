import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/providers/url_provider.dart';
import 'package:viral_vibes_mobile/src/providers/user_service_providers.dart';
import 'package:viral_vibes_mobile/src/routes/route_names.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PaymentDetailScreen extends ConsumerStatefulWidget {
  const PaymentDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends ConsumerState<PaymentDetailScreen> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    final url = ref.read(urlProvider).url;

    _controller = WebViewController()
      ..loadRequest(
        Uri.parse(url),
      )
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (change) {
          print(change.url);
          if (change.url == 'https://api.viralvibes.hawkitpro.com/dashboard') {
            final result = ref.refresh(getUserProvider.future);
            result;
            GoRouter.of(context).goNamed(
              RouteName.dashboard,
            );
          }
        },
      ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      body: SafeArea(
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
