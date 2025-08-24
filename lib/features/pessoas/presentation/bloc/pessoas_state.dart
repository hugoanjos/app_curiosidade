import '../../domain/entities/response_pessoas.dart';
import 'package:equatable/equatable.dart';

class PessoasState extends Equatable {
  final bool isLoading;
  final String? error;
  final ResponsePessoas? response;

  const PessoasState({
    this.isLoading = false,
    this.error,
    this.response,
  });

  PessoasState copyWith({
    bool? isLoading,
    String? error,
    ResponsePessoas? response,
  }) {
    return PessoasState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, response];
}
