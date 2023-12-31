import 'package:hooks_riverpod/hooks_riverpod.dart';

final bottomNavStateNotifierProvider =
    StateNotifierProvider<BottomNavStateNotifier, int>((ref) {
  return BottomNavStateNotifier(0);
});

class BottomNavStateNotifier extends StateNotifier<int> {
  BottomNavStateNotifier(int initialValue) : super(initialValue);

  void goTo(int index) {
    state = index;
  }

  void next() {
    state = state++;
  }

  void previous() {
    if (state != 0) {
      state = state--;
    }
  }
}
