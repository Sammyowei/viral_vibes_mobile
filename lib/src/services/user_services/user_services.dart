import 'dart:convert';

import 'package:viral_vibes_mobile/src/models/service_model.dart';
import 'package:viral_vibes_mobile/src/models/user_model.dart';
import 'package:viral_vibes_mobile/src/services/network/_network_exception.dart';
import 'package:viral_vibes_mobile/src/services/network/network.dart';

class UserServices {
  UserServices(String? identifier)
      : _identifier = identifier ?? 'samuelsonowei04@gmail.com';
  final String _identifier;

  final networkClient = NetworkClient('https://api.viralvibes.hawkitpro.com');

  Future<User?> getUser() async {
    final encodedIdentifier = Uri.encodeComponent(_identifier);

    final endpoint = 'api/user/$encodedIdentifier';

    try {
      final response = await networkClient.getRequest(endpoint);

      final decodedBody = jsonDecode(response.body);

      final user = User.fromJson(decodedBody);

      return user;
    } on NetworkException catch (error) {
      throw NetworkException(error.message);
    }
  }

  Future<List<Service>> getServices() async {
    final serivceList = <Service>[];

    const endpoint = 'api/service/services';

    try {
      final response = await networkClient.getRequest(endpoint);

      final decodedBody = jsonDecode(response.body);

      if (decodedBody is List<dynamic>) {
        for (var services in decodedBody) {
          final service = Service.fromJson(services);

          serivceList.add(service);
        }
      }

      return serivceList;
    } on NetworkException catch (error) {
      throw NetworkException(error.message);
    }
  }
}
