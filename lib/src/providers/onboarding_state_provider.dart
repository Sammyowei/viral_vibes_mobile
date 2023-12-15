import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingStateProvider =
    StateNotifierProvider<OnboardingPageNotifier, int>((ref) {
  return OnboardingPageNotifier();
});

class OnboardingPageNotifier extends StateNotifier<int> {
  OnboardingPageNotifier() : super(0);

  void next(int pagesLength) {
    if (state == pagesLength) {
      if (kDebugMode) {
        print('hello');
      }
      state = state;
    } else {
      if (kDebugMode) {
        print('state increment');
      }
      state = state += 1;
    }
  }

  void previous() {
    if (state == 0) {
      state = state;
    } else {
      state = state -= 1;
    }
  }

  void pageAtIndex(int pageIndex) {
    state = state = pageIndex;
  }
}
