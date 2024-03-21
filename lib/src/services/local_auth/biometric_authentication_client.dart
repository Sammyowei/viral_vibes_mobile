import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:viral_vibes_mobile/src/services/local_auth/biometric_authentication_state.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class BiometricAuthenticationClient {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Initiates the biometric authentication process and returns the corresponding state.
  ///
  /// Returns a [BiometricAuthenticationState] representing the outcome of the authentication.
  /// Possible states include [BiometricAuthenticated], [BiometricAuthenticationFailed],
  /// [BiometricAuthenticationCanceled], [BiometricNotAvailable], or [BiometricLockedOut].
  Future<BiometricAuthenticationState> authenticate() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    if (!canCheckBiometrics) {
      return BiometricNotAvailable();
    }

    List<BiometricType> availableBiometrics =
        await _localAuth.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      return BiometricNotAvailable();
    }

    try {
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Sign in to your account securely using Face ID.',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          sensitiveTransaction: true,
          useErrorDialogs: true,
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(),
          IOSAuthMessages(cancelButton: 'cancel'),
        ],
      );

      if (isAuthenticated) {
        return BiometricAuthenticated();
      } else {
        return BiometricAuthenticationCanceled();
      }
    } on PlatformException catch (e) {
      if (e.code == 'lockout') {
        return BiometricLockedOut(
            'Biometric authentication is locked out. Please try again later.');
      } else if (e.message == 'Authentication canceled.') {
        return BiometricAuthenticationCanceled();
      } else {
        return BiometricAuthenticationFailed('An error occurred: ${e.message}');
      }
    } catch (e) {
      return BiometricAuthenticationFailed('An unexpected error occurred: $e');
    }
  }

  /// Cancels the ongoing biometric authentication process.
  ///
  /// Stops the ongoing biometric authentication operation.
  Future<void> cancelAuthentication() async {
    await _localAuth.stopAuthentication();
  }

  /// Checks if biometric authentication is available on the device.
  ///
  /// Returns a boolean indicating whether biometric authentication is available.
  Future<bool> isBiometricAvailable() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  /// Retrieves the list of available biometric types supported by the device.
  ///
  /// Returns a list of [BiometricType].
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return _localAuth.getAvailableBiometrics();
  }
}
