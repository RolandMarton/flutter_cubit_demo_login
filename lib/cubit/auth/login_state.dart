import 'package:login_cubit_test/enums/login_status_enum.dart';

class LoginState {
  final LoginStatus status;
  final String? error;

  const LoginState({this.status = LoginStatus.initial, this.error});

  LoginState copyWith({LoginStatus? status, String? error}) {
    return LoginState(status: status ?? this.status, error: error);
  }
}
