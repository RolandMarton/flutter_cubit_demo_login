import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_cubit_test/cubit/auth/login_state.dart';
import 'package:login_cubit_test/cubit/user_cubit.dart';

import 'package:login_cubit_test/repository/auth_repository.dart';
import 'package:login_cubit_test/repository/user_repository.dart';

import 'package:login_cubit_test/services/analytics_service.dart';
import 'package:login_cubit_test/enums/login_status_enum.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final UserCubit _userCubit;
  final AnalyticsService _analyticsService;

  LoginCubit(this._authRepository, this._userCubit, this._analyticsService, this._userRepository)
    : super(const LoginState());

  Future<void> login(String username, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final success = await _authRepository.login(username, password);

    if (success) {
      final user = await _userRepository.getUser(username);
      _analyticsService.logEvent('login', params: {'username': user.username});
      _userCubit.setUser(user);

      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(state.copyWith(status: LoginStatus.failure, error: 'Invalid credentials'));
    }

    emit(state.copyWith(status: LoginStatus.initial));
  }
}
