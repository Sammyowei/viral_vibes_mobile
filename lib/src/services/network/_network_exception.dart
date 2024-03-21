// Custom exception class for network-related issues
import 'dart:convert';

class NetworkException implements Exception {
  final String message;
  final Map<String, dynamic>? body;

  /// Constructor that takes a [message] describing the exception
  NetworkException(this.message, {this.body});

  Map<String, dynamic> get errorData {
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

  String? get errorMessage {
    final startIndex = message.indexOf('{');
    final endIndex = message.lastIndexOf('}');

    final bodySubSring = message.substring(startIndex, endIndex + 1);

    Map<String, dynamic> decodedBody = json.decode(bodySubSring);

    final value = decodedBody['error'] as String;

    return value;
  }

  @override
  String toString() => 'NetworkException: $message body:$body';
}
