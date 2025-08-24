import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/features/splash/presentation/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/auth/auth_cubit.dart';

const Color kBackground = Color(0xFFF8F9FA);
const Color kSurface = Color(0xFFE9ECEF);
const Color kCard = Color(0xFFDEE2E6);
const Color kBorder = Color(0xFFCED4DA);
const Color kAccent = Color(0xFFADB5BD);
const Color kText = Color(0xFF212529);
const Color kTextSecondary = Color(0xFF343A40);
const Color kButton = Color(0xFF495057);
const Color kButtonAlt = Color(0xFF6C757D);

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
        scaffoldBackgroundColor: kBackground,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: kButton,
          onPrimary: Colors.white,
          secondary: kAccent,
          onSecondary: Colors.white,
          surface: kSurface,
          onSurface: kTextSecondary,
          error: Colors.red,
          onError: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kSurface,
          foregroundColor: kText,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kButton,
          foregroundColor: Colors.white,
        ),
        cardColor: kCard,
        textTheme: ThemeData.light().textTheme.copyWith(
              headlineLarge:
                  const TextStyle(color: kText, fontWeight: FontWeight.bold),
              titleLarge:
                  const TextStyle(color: kText, fontWeight: FontWeight.bold),
              bodyLarge: const TextStyle(color: kTextSecondary),
              bodyMedium: const TextStyle(color: kTextSecondary),
              titleMedium: const TextStyle(color: kButton),
              labelLarge: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kCard,
          labelStyle: const TextStyle(color: kTextSecondary),
          hintStyle: const TextStyle(color: kAccent),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kBorder),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kButton, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: kButton,
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kButton,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kButton,
            side: const BorderSide(color: kButton),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        // Add more theme customizations as needed
      ),
      home: const SplashPage(),
    );
  }
}
