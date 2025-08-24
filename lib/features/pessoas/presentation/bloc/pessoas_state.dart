import '../../domain/entities/pessoa.dart';
import 'package:equatable/equatable.dart';

class PessoasState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<Pessoa> pessoas;

  const PessoasState({
    this.isLoading = false,
    this.error,
    this.pessoas = const [],
  });

  PessoasState copyWith({
    bool? isLoading,
    String? error,
    List<Pessoa>? pessoas,
  }) {
    return PessoasState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      pessoas: pessoas ?? this.pessoas,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, pessoas];
}
