import 'package:flutter/material.dart';
import 'package:app_curiosidade/features/pessoas/domain/entities/pessoa.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_curiosidade/features/pessoas/presentation/bloc/pessoas_bloc.dart';
import 'package:app_curiosidade/features/pessoas/presentation/bloc/pessoas_event.dart';
import 'package:app_curiosidade/features/pessoas/presentation/bloc/pessoas_state.dart';

class PessoaFormPage extends StatefulWidget {
  final Pessoa? pessoa;
  const PessoaFormPage({super.key, this.pessoa});

  @override
  State<PessoaFormPage> createState() => _PessoaFormPageState();
}

class _PessoaFormPageState extends State<PessoaFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeController;
  late TextEditingController idadeController;
  late TextEditingController emailController;
  late TextEditingController enderecoController;
  late TextEditingController outrasInfoController;
  late TextEditingController interessesController;
  late TextEditingController sentimentosController;
  late TextEditingController valoresController;
  bool ativo = true;

  @override
  void initState() {
    super.initState();
    final p = widget.pessoa;
    nomeController = TextEditingController(text: p?.nome ?? '');
    idadeController =
        TextEditingController(text: p != null ? p.idade.toString() : '');
    emailController = TextEditingController(text: p?.email ?? '');
    enderecoController = TextEditingController(text: p?.endereco ?? '');
    outrasInfoController =
        TextEditingController(text: p?.outrasInformacoes ?? '');
    interessesController = TextEditingController(text: p?.interesses ?? '');
    sentimentosController = TextEditingController(text: p?.sentimentos ?? '');
    valoresController = TextEditingController(text: p?.valores ?? '');
    ativo = p?.ativo ?? true;
  }

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    emailController.dispose();
    enderecoController.dispose();
    outrasInfoController.dispose();
    interessesController.dispose();
    sentimentosController.dispose();
    valoresController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final pessoa = Pessoa(
        id: widget.pessoa?.id ?? 0,
        nome: nomeController.text.trim(),
        idade: int.tryParse(idadeController.text.trim()) ?? 0,
        email: emailController.text.trim(),
        endereco: enderecoController.text.trim().isEmpty
            ? null
            : enderecoController.text.trim(),
        outrasInformacoes: outrasInfoController.text.trim().isEmpty
            ? null
            : outrasInfoController.text.trim(),
        interesses: interessesController.text.trim().isEmpty
            ? null
            : interessesController.text.trim(),
        sentimentos: sentimentosController.text.trim().isEmpty
            ? null
            : sentimentosController.text.trim(),
        valores: valoresController.text.trim().isEmpty
            ? null
            : valoresController.text.trim(),
        dataCadastro: widget.pessoa?.dataCadastro ?? DateTime.now(),
        ativo: ativo,
        deletado: widget.pessoa?.deletado ?? false,
      );
      if (widget.pessoa != null) {
        context.read<PessoasBloc>().add(AtualizarPessoaEvent(pessoa));
      } else {
        context.read<PessoasBloc>().add(CriarPessoaEvent(pessoa));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PessoasBloc, PessoasState>(
      listener: (context, state) {
        if (state.success == true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(true);
            }
          });
        } else if (state.error != null && state.error!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.pessoa == null ? 'Novo Cadastro' : 'Editar Cadastro'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Nome obrigatório' : null,
                ),
                TextFormField(
                  controller: idadeController,
                  decoration: const InputDecoration(labelText: 'Idade'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Idade obrigatória' : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Email obrigatório' : null,
                ),
                TextFormField(
                  controller: enderecoController,
                  decoration: const InputDecoration(labelText: 'Endereço'),
                ),
                TextFormField(
                  controller: outrasInfoController,
                  decoration:
                      const InputDecoration(labelText: 'Outras Informações'),
                  maxLines: 2,
                ),
                TextFormField(
                  controller: interessesController,
                  decoration: const InputDecoration(labelText: 'Interesses'),
                  maxLines: 2,
                ),
                TextFormField(
                  controller: sentimentosController,
                  decoration: const InputDecoration(labelText: 'Sentimentos'),
                  maxLines: 2,
                ),
                TextFormField(
                  controller: valoresController,
                  decoration: const InputDecoration(labelText: 'Valores'),
                  maxLines: 2,
                ),
                DropdownButtonFormField<bool>(
                  initialValue: ativo,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(value: true, child: Text('Ativo')),
                    DropdownMenuItem(value: false, child: Text('Desativado')),
                  ],
                  onChanged: (v) => setState(() => ativo = v ?? true),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<PessoasBloc, PessoasState>(
                      builder: (context, state) => ElevatedButton(
                        onPressed: state.isLoading ? null : _save,
                        child: state.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Salvar'),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
