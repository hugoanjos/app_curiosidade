import 'package:flutter/material.dart';
import 'package:app_curiosidade/features/pessoas/domain/entities/pessoa.dart';

class CardPessoa extends StatelessWidget {
  final Pessoa pessoa;
  final bool showActions;
  final VoidCallback? onTap;

  const CardPessoa({
    super.key,
    required this.pessoa,
    this.showActions = true,
    this.onTap,
  });

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

    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(pessoa.nome.isNotEmpty ? pessoa.nome[0] : '?'),
          ),
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
                )
              : Icon(
                  pessoa.ativo ? Icons.check_circle : Icons.cancel,
                  color: pessoa.ativo ? Colors.green : Colors.red,
                ),
        ),
      ),
    );
  }
}
