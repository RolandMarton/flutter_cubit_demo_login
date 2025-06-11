import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_cubit_test/cubit/user_cubit.dart';
import 'package:login_cubit_test/cubit/theme/theme_cubit.dart';

import 'package:login_cubit_test/repository/auth_repository.dart';
import 'package:login_cubit_test/repository/user_repository.dart';
import 'package:login_cubit_test/screens/admin_screen.dart';

import 'package:login_cubit_test/screens/home_screen.dart';
import 'package:login_cubit_test/screens/login_screen.dart';

import 'package:login_cubit_test/services/analytics_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        /// [Global Repositories]
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserRepository()),

        /// [Global Services]
        RepositoryProvider(create: (_) => AnalyticsService()),
      ],
      child: MultiBlocProvider(
        providers: [
          /// [Global Cubits]
          BlocProvider(create: (context) => UserCubit(context.read<AuthRepository>())),
          BlocProvider(create: (context) => ThemeCubit(context.read<AnalyticsService>())),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              /// [Base info]
              title: 'Cubit Architecture Demo',
              debugShowCheckedModeBanner: false,

              /// [Theming]
              themeMode: themeMode,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),

              /// [Route management]
              initialRoute: '/',
              routes: {'/': (_) => LoginPage(), '/home': (_) => const HomePage(), '/admin': (_) => const AdminPage()},
            );
          },
        ),
      ),
    );
  }
}
