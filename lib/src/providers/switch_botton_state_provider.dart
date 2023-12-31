import 'package:hooks_riverpod/hooks_riverpod.dart';

final switchButtonStateNotifierProvider =
    StateNotifierProvider<SwitchButtonStateNotifier, bool>((ref) {
  return SwitchButtonStateNotifier(stateValue: false);
});

class SwitchButtonStateNotifier extends StateNotifier<bool> {
  SwitchButtonStateNotifier({bool stateValue = false}) : super(stateValue);

  void setState(bool value) async {
    state = value;
  }
}
