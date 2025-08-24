import '../../domain/entities/response_pessoas.dart';
import 'package:equatable/equatable.dart';

class PessoasState extends Equatable {
  final bool isLoading;
  final String? error;
  final ResponsePessoas? response;
  final bool? success;

  const PessoasState({
    this.isLoading = false,
    this.error,
    this.response,
    this.success,
  });

  PessoasState copyWith({
    bool? isLoading,
    String? error,
    ResponsePessoas? response,
    bool? success,
  }) {
    return PessoasState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      response: response ?? this.response,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, response, success];
}
