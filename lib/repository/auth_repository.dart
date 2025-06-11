import 'package:login_cubit_test/models/user.dart';
import 'package:login_cubit_test/repository/database_helper.dart';

class AuthRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    bool isUser = username == 'user' && password == 'password';
    bool isAdmin = username == 'admin' && password == 'password';

    if (isUser || isAdmin) {
      final user = User(username: username, email: '$username@example.com');
      await _saveUser(user);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final db = await _dbHelper.database;
    await db.delete('users');
  }

  Future<User?> getUser() async {
    final db = await _dbHelper.database;
    final maps = await db.query('users', limit: 1);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> _saveUser(User user) async {
    final db = await _dbHelper.database;
    await db.delete('users');
    await db.insert('users', user.toMap());
  }
}
