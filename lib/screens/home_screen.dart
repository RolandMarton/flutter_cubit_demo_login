import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_cubit_test/cubit/user_cubit.dart';
import 'package:login_cubit_test/cubit/theme_cubit.dart';

import 'package:login_cubit_test/repository/auth_repository.dart';

import 'package:login_cubit_test/services/analytics_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) Text('Welcome, ${user.username} (${user.email})'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await context.read<AuthRepository>().logout();

                if (context.mounted) {
                  context.read<AnalyticsService>().logEvent('logout');
                  context.read<UserCubit>().clearUser();
                  Navigator.pushReplacementNamed(context, '/');
                }
              },
              child: const Text('Logout'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              child: const Text('Toggle Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
