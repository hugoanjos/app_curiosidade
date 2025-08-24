import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isFormValid;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const LoginState({
    this.isFormValid = false,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  LoginState copyWith({
    bool? isFormValid,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return LoginState(
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isFormValid, isLoading, error, isSuccess];
}
