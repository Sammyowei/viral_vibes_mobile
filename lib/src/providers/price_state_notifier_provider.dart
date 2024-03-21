import 'package:hooks_riverpod/hooks_riverpod.dart';

final priceNotifierProvider =
    StateNotifierProvider<PriceNotifier, double>((ref) {
  return PriceNotifier();
});

class PriceNotifier extends StateNotifier<double> {
  PriceNotifier() : super(0);

  void restart() {
    state = 0;
  }

  void calculatePrice(double rate, int amount) {
    final ratePerOne = rate / 1000;
    state = amount * ratePerOne;
  }
}
