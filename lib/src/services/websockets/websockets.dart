import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

class WSSWebSocket {
  late final WebSocketChannel _channel;

  WSSWebSocket({
    required String url,
  }) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  Stream listenMessages() {
    return _channel.stream;
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void closeWebSocket() {
    _channel.sink.close();
  }
}
