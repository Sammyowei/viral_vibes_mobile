// ignore: non_constant_identifier_names
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:viral_vibes_mobile/src/services/auth_state_client.dart';
import 'package:viral_vibes_mobile/src/services/local_auth/biometric_authentication_client.dart';

final authenticationManagerProvider = Provider<AuthenticationManager>((ref) {
  return AuthenticationManager();
});

final biometricEnabledProvider = FutureProvider<bool>((ref) async {
  final authenticationManager = ref.watch(authenticationManagerProvider);

  return authenticationManager.isEnabled();
});

final biometricProvider = Provider<BiometricAuthenticationClient>((ref) {
  return BiometricAuthenticationClient();
});

final availableBiometricProvider =
    FutureProvider<List<BiometricType>>((ref) async {
  final biometric = ref.watch(biometricProvider);
  return biometric.getAvailableBiometrics();
});
