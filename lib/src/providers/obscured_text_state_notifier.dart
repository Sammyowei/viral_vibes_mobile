import 'package:hooks_riverpod/hooks_riverpod.dart';

final passwordObscuringTextNotifierProvider =
    StateNotifierProvider<ObscureTextNotifier, bool>((ref) {
  return ObscureTextNotifier();
});

final confirmPasswordObscuringTextNotifierProvider =
    StateNotifierProvider<ObscureTextNotifier, bool>(
        (ref) => ObscureTextNotifier());
final loginAuthStateCompleteNotifierProvider =
    StateNotifierProvider<ObscureTextNotifier, bool>(
        (ref) => ObscureTextNotifier());

final signUpAuthStateCompleteNotifierProvider =
    StateNotifierProvider<ObscureTextNotifier, bool>((ref) {
  return ObscureTextNotifier();
});

final otpFormStateCompleteNotifierProvider =
    StateNotifierProvider<BooleanStateNotifier, bool>((ref) {
  return BooleanStateNotifier();
});

final sendButtonProvider =
    StateNotifierProvider<ObscureTextNotifier, bool>((ref) {
  return ObscureTextNotifier();
});

class ObscureTextNotifier extends StateNotifier<bool> {
  ObscureTextNotifier() : super(false);

  void tuggle() {
    state = !state;
  }

  void hide() {
    state = state = true;
  }

  void show() {
    state = state = false;
  }
}

class BooleanStateNotifier extends StateNotifier<bool> {
  BooleanStateNotifier() : super(false);

  void isTrue() {
    state = true;
  }

  void isFalse() {
    state = false;
  }

  void tuggleValue() {
    state = !state;
  }
}
