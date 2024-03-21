// Importing the http package and aliasing it as 'http'
import 'package:http/http.dart' as http;

// Abstract class defining a network service for HTTP requests
abstract class NetworkService {
  /// Makes a GET request to the specified [endpoint].
  ///
  /// Optional [headers] can be provided.
  Future<http.Response> getRequest(
    String endpoint, {
    Map<String, String>? headers,
  });

  /// Makes a POST request to the specified [endpoint] with a [body].
  ///
  /// Optional [headers] can be provided.
  Future<http.Response> postRequest(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  });

  /// Makes a PUT request to the specified [endpoint] with a [body].
  ///
  /// Optional [headers] can be provided.
  Future<http.Response> putRequest(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  });

  /// Makes a DELETE request to the specified [endpoint].
  ///
  /// Optional [headers] can be provided.
  Future<http.Response> deleteRequest(
    String endpoint, {
    Map<String, String>? headers,
  });
}
