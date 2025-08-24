import 'package:equatable/equatable.dart';

abstract class CadastroState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CadastroInitial extends CadastroState {}

class CadastroLoading extends CadastroState {}

class CadastroSuccess extends CadastroState {}

class CadastroError extends CadastroState {
  final String message;
  CadastroError(this.message);

  @override
  List<Object?> get props => [message];
}
