import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';
import 'package:app_curiosidade/features/login/presentation/login_page.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  void _logout(BuildContext context) {
    context.read<AuthCubit>().clearAuth();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final nome = state.nome ?? 'Usuário';
        return Scaffold(
          appBar: AppBar(title: const Text('Usuário')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 48,
                  child: Icon(Icons.person, size: 48),
                ),
                const SizedBox(height: 16),
                Text(
                  nome,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement password change flow
                    },
                    child: const Text('Alterar Senha'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: () => _logout(context),
                    child: const Text('Sair'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
