import 'package:hooks_riverpod/hooks_riverpod.dart';

final passwordObscuringTextNotifierProvider =
    StateNotifierProvider<ObscureTextNotifier, bool>((ref) {
  return ObscureTextNotifier();
});

final authStateCompleteNotifierProvider =
    StateNotifierProvider<ObscureTextNotifier, bool>(
        (ref) => ObscureTextNotifier());

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
