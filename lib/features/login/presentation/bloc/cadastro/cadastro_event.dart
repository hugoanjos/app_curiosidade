import 'package:equatable/equatable.dart';

abstract class CadastroEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CadastrarUsuario extends CadastroEvent {
  final String nome;
  final String email;
  final String senha;

  CadastrarUsuario(this.nome, this.email, this.senha);

  @override
  List<Object?> get props => [nome, email, senha];
}
