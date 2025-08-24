import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_curiosidade/shared/components/snackbar.dart';
import 'bloc/cadastro/cadastro_bloc.dart';
import 'bloc/cadastro/cadastro_event.dart';
import 'bloc/cadastro/cadastro_state.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});
  @override
  CadastroPageState createState() => CadastroPageState();
}

class CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void _cadastrar(BuildContext context) {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();
    context.read<CadastroBloc>().add(CadastrarUsuario(nome, email, senha));
  }

  void _onFormChanged(BuildContext context) {
    context.read<CadastroBloc>().add(
          CadastroFormChanged(
            nomeController.text,
            emailController.text,
            senhaController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CadastroBloc(),
      child: BlocConsumer<CadastroBloc, CadastroState>(
        listener: (context, state) {
          if (state.error != null) {
            errorSnackBar(state.error!, context);
          }
          if (state.isSuccess) {
            successSnackBar('Usuário criado!', context);
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Cadastro'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: nomeController,
                          decoration: const InputDecoration(labelText: 'Nome'),
                          onChanged: (_) => _onFormChanged(context),
                        ),
                        const SizedBox(height: 12),
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
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state.isLoading || !state.isFormValid
                                ? null
                                : () => _cadastrar(context),
                            child: state.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text('Cadastrar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
