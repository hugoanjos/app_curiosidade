import 'package:flutter/material.dart';
import 'package:app_curiosidade/features/pessoas/domain/entities/pessoa.dart';
import 'package:app_curiosidade/features/pessoas/presentation/pessoa_form_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_curiosidade/features/pessoas/presentation/bloc/pessoas_bloc.dart';

class CardPessoa extends StatelessWidget {
  final Pessoa pessoa;
  final bool showActions;
  final VoidCallback? onTap;
  final VoidCallback? onEditSuccess;

  const CardPessoa({
    super.key,
    required this.pessoa,
    this.showActions = true,
    this.onTap,
    this.onEditSuccess,
  });

  Widget _infoRow(String label, String value, {bool multiline = false}) {
    if (multiline) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(value),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<dynamic> dialogMostrarInformacoes(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Informações do Cadastro'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow('Nome', pessoa.nome),
                _infoRow('Idade', pessoa.idade.toString()),
                _infoRow('Email', pessoa.email),
                _infoRow('Endereço', pessoa.endereco ?? ''),
                _infoRow('Outras Informações', pessoa.outrasInformacoes ?? '',
                    multiline: (pessoa.outrasInformacoes ?? '').isNotEmpty),
                _infoRow('Interesses', pessoa.interesses ?? '',
                    multiline: (pessoa.interesses ?? '').isNotEmpty),
                _infoRow('Sentimentos', pessoa.sentimentos ?? '',
                    multiline: (pessoa.sentimentos ?? '').isNotEmpty),
                _infoRow('Valores', pessoa.valores ?? '',
                    multiline: (pessoa.valores ?? '').isNotEmpty),
                _infoRow('Status', pessoa.ativo ? 'Ativo' : 'Desativado'),
                _infoRow('Data de Cadastro', _formatDate(pessoa.dataCadastro)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCadastroPendente = [
      pessoa.nome,
      pessoa.email,
      pessoa.endereco,
      pessoa.outrasInformacoes,
      pessoa.interesses,
      pessoa.sentimentos,
      pessoa.valores,
    ].any((field) => field == null || field.isEmpty);

    return Card(
      child: ListTile(
        title: Text(pessoa.nome),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pessoa.email),
            if (isCadastroPendente)
              const Text(
                'Cadastro pendente',
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
          ],
        ),
        trailing: showActions
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    pessoa.ativo ? Icons.check_circle : Icons.cancel,
                    color: pessoa.ativo ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      dialogMostrarInformacoes(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final bloc =
                          BlocProvider.of<PessoasBloc>(context, listen: false);
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: bloc,
                            child: PessoaFormPage(pessoa: pessoa),
                          ),
                        ),
                      );
                      if (result == true && onEditSuccess != null) {
                        onEditSuccess!();
                      }
                    },
                  ),
                ],
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
