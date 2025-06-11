class AuthRepository {
  Future<bool> login(String username, String password) async {
    // Call API or DB
    await Future.delayed(const Duration(seconds: 1));
    return username == 'admin' && password == 'password';
  }

  Future<void> logout() async {
    // Clear session
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
