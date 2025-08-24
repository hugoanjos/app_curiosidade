import 'package:equatable/equatable.dart';

class UsuarioState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const UsuarioState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  UsuarioState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return UsuarioState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, isSuccess];
}
