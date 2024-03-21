import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationState { biometricsDisabled, boimetricsEnabled }

class AuthenticationManager {
  late SharedPreferences _prefs;
  static const String _authKey = 'authenticated';

  AuthenticationManager() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<AuthenticationState> checkAuthenticationState() async {
    final bool isAuthenticated = _prefs.getBool(_authKey) ?? false;

    if (isAuthenticated) {
      return AuthenticationState.boimetricsEnabled;
    } else {
      return AuthenticationState.biometricsDisabled;
    }
  }

  Future<bool> isEnabled() async {
    await _init();
    return _prefs.getBool(_authKey) ?? false;
  }

  void enableBiometrics() async {
    await _prefs.setBool(_authKey, true);
  }

  Future<void> disableBiometrics() async {
    await _prefs.setBool(_authKey, false);
  }
}

class CachedUserIdentifier {
  late SharedPreferences _prefs;
  static const String _cachedUserKey = 'cacheduser';

  CachedUserIdentifier() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setUser(String id) async {
    await init(); // Ensure _prefs is initialized before setting user
    await _prefs.setString(_cachedUserKey, id);
  }

  Future<String> getUserId() async {
    await init(); // Ensure _prefs is initialized before getting user
    return _prefs.getString(_cachedUserKey) ?? "";
  }
}
