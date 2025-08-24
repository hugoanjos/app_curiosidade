import 'package:app_curiosidade/features/pessoas/domain/entities/pessoa.dart';
import 'package:equatable/equatable.dart';

abstract class PessoasEvent extends Equatable {
  const PessoasEvent();

  @override
  List<Object?> get props => [];
}

class BuscarPessoasEvent extends PessoasEvent {
  final String busca;
  const BuscarPessoasEvent(this.busca);

  @override
  List<Object?> get props => [busca];
}

class CriarPessoaEvent extends PessoasEvent {
  final Pessoa pessoa;
  const CriarPessoaEvent(this.pessoa);

  @override
  List<Object?> get props => [pessoa];
}

class AtualizarPessoaEvent extends PessoasEvent {
  final Pessoa pessoa;
  const AtualizarPessoaEvent(this.pessoa);

  @override
  List<Object?> get props => [pessoa];
}
