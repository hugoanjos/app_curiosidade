import 'package:equatable/equatable.dart';

class CadastroState extends Equatable {
  final bool isFormValid;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const CadastroState({
    this.isFormValid = false,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  CadastroState copyWith({
    bool? isFormValid,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return CadastroState(
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isFormValid, isLoading, error, isSuccess];
}
