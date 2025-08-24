import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/features/splash/presentation/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/auth/auth_cubit.dart';

void main() {
  setupInjector();
  runApp(
    BlocProvider(
      create: (_) => AuthCubit(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFf5ebe0),
      ),
      home: const SplashPage(),
    );
  }
}
