import 'package:hooks_riverpod/hooks_riverpod.dart';

class UrlProvider {
  UrlProvider({
    String url = '',
  }) : _url = url;

  String _url;

  String get url => _url;

  void setUrl(String url) {
    _url = url;
  }
}

final urlProvider = Provider<UrlProvider>((ref) {
  return UrlProvider();
});
