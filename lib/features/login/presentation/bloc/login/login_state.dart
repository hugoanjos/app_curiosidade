import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isFormValid;
  final bool isLoading;
  final String? error;
  final bool isSuccess;
  final String? token;
  final int? id;
  final String? nome;

  const LoginState({
    this.isFormValid = false,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    this.token,
    this.id,
    this.nome,
  });

  LoginState copyWith({
    bool? isFormValid,
    bool? isLoading,
    String? error,
    bool? isSuccess,
    String? token,
    int? id,
    String? nome,
  }) {
    return LoginState(
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
      token: token ?? this.token,
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  @override
  List<Object?> get props =>
      [isFormValid, isLoading, error, isSuccess, token, id, nome];
}
