abstract class AuthUtil {
  Future<Map<String, dynamic>?> createUser({
    required String email,
    required String password,
    required String mobileNumber,
    required String userName,
    String? referalcode,
  });

  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  });

  Future<void> requestOTP({
    required String accountID,
    required String userName,
  });
}
