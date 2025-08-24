import 'package:app_curiosidade/core/auth/auth_cubit.dart';
import 'package:app_curiosidade/features/login/presentation/bloc/login_bloc.dart';
import 'package:app_curiosidade/features/login/presentation/bloc/login_event.dart';
import 'package:app_curiosidade/features/login/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cadastro_page.dart';
import 'package:app_curiosidade/shared/components/snackbar.dart';
import 'package:app_curiosidade/features/home/presentation/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void _fazerLogin(BuildContext context) {
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();
    context.read<LoginBloc>().add(LoginRequested(email, senha));
  }

  void _onFormChanged(BuildContext context) {
    context.read<LoginBloc>().add(
          LoginFormChanged(emailController.text, senhaController.text),
        );
  }

  Widget _buildLogoWidget() {
    return Column(
      children: [
        CircleAvatar(
          radius: 68,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/onion.png',
              fit: BoxFit.contain,
              height: 120,
              width: 120,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Operação Curiosidade',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildFormWidget(BuildContext context, LoginState state) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (_) => _onFormChanged(context),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (_) => _onFormChanged(context),
                onSubmitted: state.isLoading || !state.isFormValid
                    ? null
                    : (_) => _fazerLogin(context),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.isLoading || !state.isFormValid
                      ? null
                      : () => _fazerLogin(context),
                  child: state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Entrar'),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CadastroPage()),
                  );
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.error != null) {
            errorSnackBar(state.error!, context);
          }
          if (state.isSuccess && state.token != null) {
            context.read<AuthCubit>().setToken(state.token!);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
        },
        builder: (context, state) => Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogoWidget(),
                  _buildFormWidget(context, state),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
