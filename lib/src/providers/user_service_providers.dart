import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:viral_vibes_mobile/src/models/service_model.dart';
import 'package:viral_vibes_mobile/src/models/user_model.dart';
import 'package:viral_vibes_mobile/src/services/user_services/user_services.dart';

final userProvider = Provider((ref) => IdentifierProvider());
final getUserProvider = FutureProvider<User?>((ref) async {
  final user = ref.watch(userProvider);

  print(" this is the user Identifier" + user.identifier);

  final userService = UserServices(user.identifier);
  return userService.getUser();
});

class IdentifierProvider {
  String _identifier;

  IdentifierProvider([String initialIdentifier = ''])
      : _identifier = initialIdentifier;

  String get identifier => _identifier;

  set identifier(String newIdentifier) {
    _identifier = newIdentifier;
  }
}

final serviceListProvider = Provider<ServiceList>((ref) {
  return ServiceList();
});

final serviceProvider = FutureProvider<List<Service>>((ref) async {
  final user = ref.watch(userProvider);

  final userService = UserServices(user.identifier);

  return userService.getServices();
});

class ServiceList {
  ServiceList({List<Service>? serviceList}) : _serviceList = serviceList ?? [];
  final List<Service> _serviceList;
  List<Service> get serviceList => _serviceList;
  void addAll(List<Service> services) {
    _serviceList.addAll(services);
  }
}
