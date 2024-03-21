/// Represents the states for biometric authentication.
///
/// This class serves as the base for various biometric authentication states.
/// Subclasses represent specific states of biometric authentication.
abstract class BiometricAuthenticationState {}

/// Represents the state when biometric authentication is successful.
class BiometricAuthenticated extends BiometricAuthenticationState {}

/// Represents the state when biometric authentication fails.
class BiometricAuthenticationFailed extends BiometricAuthenticationState {
  /// The [error] message describing the reason for authentication failure.
  final String error;

  BiometricAuthenticationFailed(this.error);
}

/// Represents the state when biometric authentication is canceled.
class BiometricAuthenticationCanceled extends BiometricAuthenticationState {}

/// Represents the state when biometric authentication is not available.
class BiometricNotAvailable extends BiometricAuthenticationState {}

/// Represents the state when biometric authentication is locked out.
class BiometricLockedOut extends BiometricAuthenticationState {
  /// The [message] indicating the reason for biometric lockout.
  final String message;

  BiometricLockedOut(this.message);
}
