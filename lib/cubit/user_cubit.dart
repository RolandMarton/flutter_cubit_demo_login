import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_cubit_test/repository/auth_repository.dart';
import 'package:login_cubit_test/models/user.dart';

class UserCubit extends Cubit<User?> {
  final AuthRepository _authRepository;

  UserCubit(this._authRepository) : super(null);

  Future<void> loadUser() async {
    final user = await _authRepository.getUser();
    emit(user);
  }

  void setUser(User user) => emit(user);

  void clearUser() => emit(null);
}
