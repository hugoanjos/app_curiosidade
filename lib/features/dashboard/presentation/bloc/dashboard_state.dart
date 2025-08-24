import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int totalCadastros;
  final int cadastrosUltimoMes;
  final int cadastrosPendentes;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.totalCadastros = 0,
    this.cadastrosUltimoMes = 0,
    this.cadastrosPendentes = 0,
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    int? totalCadastros,
    int? cadastrosUltimoMes,
    int? cadastrosPendentes,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      totalCadastros: totalCadastros ?? this.totalCadastros,
      cadastrosUltimoMes: cadastrosUltimoMes ?? this.cadastrosUltimoMes,
      cadastrosPendentes: cadastrosPendentes ?? this.cadastrosPendentes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        totalCadastros,
        cadastrosUltimoMes,
        cadastrosPendentes,
        isLoading,
        error
      ];
}
