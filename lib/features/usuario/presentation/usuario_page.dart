import 'package:app_curiosidade/shared/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';
import 'package:app_curiosidade/features/login/presentation/login_page.dart';
import 'package:app_curiosidade/features/usuario/presentation/bloc/usuario_cubit.dart';
import 'package:app_curiosidade/features/usuario/presentation/bloc/usuario_state.dart';
import 'package:app_curiosidade/features/usuario/domain/usecases/alterar_senha_usecase.dart';
import 'package:app_curiosidade/features/usuario/data/usuario_repository.dart';
import 'package:app_curiosidade/core/di.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  void _logout(BuildContext context) {
    context.read<AuthCubit>().clearAuth();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void _showAlterarSenhaDialog(BuildContext context, int id) {
    final novaSenhaController = TextEditingController();
    final confirmarSenhaController = TextEditingController();
    final token = context.read<AuthCubit>().state.token;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<UsuarioCubit>(),
          child: BlocConsumer<UsuarioCubit, UsuarioState>(
            listener: (context, state) {
              if (state.isSuccess) {
                Navigator.of(dialogContext).pop();
                successSnackBar('Senha alterada com sucesso!', context);
              } else if (state.error != null) {
                errorSnackBar(state.error!, context);
              }
            },
            builder: (context, state) {
              return AlertDialog(
                title: const Text('Alterar Senha'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: novaSenhaController,
                      decoration:
                          const InputDecoration(labelText: 'Nova senha'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: confirmarSenhaController,
                      decoration:
                          const InputDecoration(labelText: 'Confirmar senha'),
                      obscureText: true,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            final novaSenha = novaSenhaController.text.trim();
                            final confirmarSenha =
                                confirmarSenhaController.text.trim();
                            if (novaSenha.isEmpty || confirmarSenha.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Preencha ambos os campos.')),
                              );
                              return;
                            }
                            if (novaSenha != confirmarSenha) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'As senhas digitadas não são iguais!')),
                              );
                              return;
                            }
                            context.read<UsuarioCubit>().alterarSenha(
                                id: id, novaSenha: novaSenha, token: token!);
                          },
                    child: state.isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Salvar'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final nome = authState.nome ?? 'Usuário';
        final id = authState.id;
        return BlocProvider(
          create: (_) =>
              UsuarioCubit(AlterarSenhaUsecase(sl<UsuarioRepository>())),
          child: Builder(
            builder: (blocContext) => Scaffold(
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
                        onPressed: id == null
                            ? null
                            : () => _showAlterarSenhaDialog(blocContext, id),
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
            ),
          ),
        );
      },
    );
  }
}
