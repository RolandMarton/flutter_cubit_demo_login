import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_cubit_test/controllers/form_controller.dart';

import 'package:login_cubit_test/cubit/user_cubit.dart';
import 'package:login_cubit_test/cubit/auth/login_cubit.dart';
import 'package:login_cubit_test/cubit/auth/login_state.dart';

import 'package:login_cubit_test/repository/auth_repository.dart';
import 'package:login_cubit_test/repository/user_repository.dart';

import 'package:login_cubit_test/models/user.dart';
import 'package:login_cubit_test/enums/login_status_enum.dart';
import 'package:login_cubit_test/services/analytics_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formController = LoginFormController();

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => LoginCubit(
            context.read<AuthRepository>(),
            context.read<UserCubit>(),
            context.read<AnalyticsService>(),
            context.read<UserRepository>(),
          ),
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            /// [Login success]
            if (state.status == LoginStatus.success) {
              final user = User(
                username: _formController.usernameController.text.trim(),
                email: _formController.fakeEmail!,
              );

              context.read<UserCubit>().setUser(user);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful!')));

              Future.delayed(Duration(milliseconds: 300), () {
                if (context.mounted) Navigator.pushReplacementNamed(context, '/home');
              });
            }
            /// [Login failed]
            else if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error ?? 'Login failed')));
            }
          },
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _formController.usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: _formController.validateUsername,
                    ),
                    TextFormField(
                      controller: _formController.passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: _formController.validatePassword,
                    ),
                    SizedBox(height: 16),
                    state.status == LoginStatus.loading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.login(
                                _formController.usernameController.text.trim(),
                                _formController.passwordController.text.trim(),
                              );
                            }
                          },
                          child: Text('Login'),
                        ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
