import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/model.dart';

final userDataProvider = Provider<User>(
  (ref) {
    final data = ref.watch(dataGetterProvider);
    return User.fromJson(data.data);
  },
);

final dataGetterProvider = Provider((ref) => UserDataGetter());

class UserDataGetter {
  UserDataGetter({Map<String, dynamic> data = const {}}) : _data = data;

  Map<String, dynamic> get data => _data;
  Map<String, dynamic> _data;

  set userData(Map<String, dynamic> json) {
    _data = json;
  }
}
