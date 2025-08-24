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
