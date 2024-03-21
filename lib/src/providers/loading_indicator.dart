import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingIndicatorProvider =
    StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});

final addFundsLoadingProvider =
    StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});

final amountValidatorProvider =
    StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});

final orderValidProvider = StateNotifierProvider<LoadingNotifier, bool>(
  (ref) => LoadingNotifier(),
);

final orderLoadingProvider = StateNotifierProvider<LoadingNotifier, bool>(
  (ref) => LoadingNotifier(),
);

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  void isLoading() {
    state = state = true;
  }

  void finishedloading() {
    state = state = false;
  }

  void tuggle() {
    state = !state;
  }
}
