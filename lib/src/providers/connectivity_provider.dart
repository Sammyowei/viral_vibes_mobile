import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityProvider = StreamProvider.autoDispose<ConnectivityResult>(
  (ref) => Connectivity().onConnectivityChanged,
);
