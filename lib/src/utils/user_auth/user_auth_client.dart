import 'dart:convert';

import 'package:viral_vibes_mobile/src/services/network/_network_exception.dart';
import 'package:viral_vibes_mobile/src/services/network/network.dart';
import 'package:viral_vibes_mobile/src/utils/user_auth/user_auth_util.dart';

class Authentication extends AuthUtil {
  final networkCommunicator =
      NetworkClient('https://api.viralvibes.hawkitpro.com');

  //
  @override
  Future<Map<String, dynamic>?> createUser({
    required String email,
    required String password,
    required String mobileNumber,
    required String userName,
    String? referalcode,
  }) async {
    try {
      final data = {
        "email": email,
        "password": password,
        "userName": userName,
        "mobileNumber": mobileNumber,
        "referalCode": referalcode,
      };

      const endpoint = 'api/auth/signup';

      final body = json.encode(data);

      final response = await networkCommunicator.postRequest(endpoint, body);

      final decodedBody = jsonDecode(response.body);

      print(decodedBody);

      print(decodedBody as Map<String, dynamic>);
      return decodedBody;
    } on NetworkException catch (err) {
      final message = err.message;

      final startIndex = message.indexOf('{');
      final endIndex = message.lastIndexOf('}');

      final bodySubSring = message.substring(startIndex, endIndex + 1);

      String validJson = bodySubSring.replaceAllMapped(
        RegExp(r'(\w+)\s*:\s*([^,}]+)'),
        (Match match) => '"${match.group(1)}": "${match.group(2)}"',
      );

      final jsonData = jsonDecode(validJson);

      print(json.encode(jsonData));
      return jsonData;
    }
  }

  @override
  Future<Map<String, dynamic>?> loginUser(
      {required String email, required String password}) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };

      const endpoint = "api/auth/signin";

      final encodedData = jsonEncode(data);
      final response =
          await networkCommunicator.postRequest(endpoint, encodedData);

      final body = jsonDecode(response.body);

      return body;
    } on NetworkException catch (err) {
      final message = err.message;

      final startIndex = message.indexOf('{');
      final endIndex = message.lastIndexOf('}');

      final bodySubSring = message.substring(startIndex, endIndex + 1);

      String validJson = bodySubSring.replaceAllMapped(
        RegExp(r'(\w+)\s*:\s*([^,}]+)'),
        (Match match) => '"${match.group(1)}": "${match.group(2)}"',
      );

      final jsonData = jsonDecode(validJson);
      return jsonData;
    }
  }

  @override
  Future<void> requestOTP(
      {required String accountID, required String userName}) {
    // TODO: implement requestOTP
    throw UnimplementedError();
  }
}
