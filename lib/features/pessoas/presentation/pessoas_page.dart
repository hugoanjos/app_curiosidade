import 'dart:async';

import 'package:app_curiosidade/features/login/presentation/bloc/cadastro/cadastro_bloc.dart';
import 'package:app_curiosidade/features/pessoas/data/pessoas_repository.dart';
import 'package:app_curiosidade/features/pessoas/domain/usecases/buscar_pessoas_usecase.dart';
import 'package:app_curiosidade/features/pessoas/presentation/bloc/pessoas_bloc.dart';
import 'package:app_curiosidade/features/pessoas/presentation/bloc/pessoas_event.dart';
import 'package:app_curiosidade/features/pessoas/presentation/bloc/pessoas_state.dart';
import 'package:app_curiosidade/shared/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PessoasPage extends StatefulWidget {
  const PessoasPage({super.key});

  @override
  State<PessoasPage> createState() => _PessoasPageState();
}

class _PessoasPageState extends State<PessoasPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context
          .read<PessoasBloc>()
          .add(BuscarPessoasEvent(_searchController.text.trim()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PessoasBloc(BuscarPessoasUsecase(sl<PessoasRepository>())),
      child: Builder(
        builder: (blocContext) {
          _searchController.addListener(() => _onSearchChanged(blocContext));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            blocContext.read<PessoasBloc>().add(const BuscarPessoasEvent(''));
          });
          return Scaffold(
            appBar: AppBar(title: const Text('Cadastros')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<PessoasBloc, PessoasState>(
                listener: (context, state) {
                  if (state.error != null && state.error!.isNotEmpty) {
                    errorSnackBar(state.error!, context);
                  }
                  if (state.response != null &&
                      state.response!.statusCode == 401) {
                    // Unauthorized: trigger logout/navigation
                    Navigator.of(context).pushReplacementNamed('/login');
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final pessoas = state.response?.pessoas ?? [];
                  if (pessoas.isEmpty) {
                    return const Center(
                        child: Text('Nenhuma pessoa cadastrada.'));
                  }
                  return Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: 'Buscar',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: pessoas.length,
                          itemBuilder: (context, index) {
                            final pessoa = pessoas[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(pessoa.nome.isNotEmpty
                                      ? pessoa.nome[0]
                                      : '?'),
                                ),
                                title: Text(pessoa.nome),
                                subtitle: Text(pessoa.email),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      pessoa.ativo
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: pessoa.ativo
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(Icons.info_outline),
                                      onPressed: () {
                                        // TODO: View all info
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        // TODO: Edit pessoa
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
