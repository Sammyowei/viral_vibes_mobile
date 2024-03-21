import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:viral_vibes_mobile/src/services/network/_network_exception.dart';
import 'package:viral_vibes_mobile/src/services/network/_network_service.dart';

class NetworkClient implements NetworkService {
  final String baseUrl;

  NetworkClient(this.baseUrl);

  bool isSuccessfulStatusCode(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  @override
  Future<http.Response> getRequest(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return _executeRequest(
      () => http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers),
    );
  }

  @override
  Future<http.Response> postRequest(
    String endpoint,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    return _executeRequest(
      () => http.post(Uri.parse('$baseUrl/$endpoint'),
          body: body, headers: headers),
    );
  }

  @override
  Future<http.Response> putRequest(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    return _executeRequest(
      () => http.put(Uri.parse('$baseUrl/$endpoint'),
          body: body, headers: headers),
    );
  }

  @override
  Future<http.Response> deleteRequest(String endpoint,
      {Map<String, String>? headers, s}) async {
    return _executeRequest(
      () => http.delete(Uri.parse('$baseUrl/$endpoint'), headers: headers),
    );
  }

  Future<http.Response> _executeRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      if (isSuccessfulStatusCode(response.statusCode)) {
        return response;
      } else {
        throw NetworkException(
          'Request failed with status code: ${response.statusCode}',
          body: json.decode(response.body),
        );
      }
    } catch (e) {
      throw NetworkException('Request failed: $e');
    }
  }
}
