import 'package:viral_vibes_mobile/src/assets_provider/image_provider.dart';

class ChatUser {
  ChatUser(
      {required this.user,
      required this.id,
      final DestinationType? destination})
      : _imageUrl = ImageProviders.manAvatar,
        _destination = destination ?? DestinationType.sender;

  final String user;
  final String id;

  DestinationType get destination => _destination;
  final DestinationType _destination;

  String get imageUrl => _imageUrl;
  final String _imageUrl;
}

enum DestinationType { reciever, sender }
