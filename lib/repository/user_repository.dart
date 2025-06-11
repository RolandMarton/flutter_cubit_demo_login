import 'package:login_cubit_test/models/user.dart';

class UserRepository {
  Future<User> getUser(String username) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return User(username: username, email: '$username@example.com');
  }
}
