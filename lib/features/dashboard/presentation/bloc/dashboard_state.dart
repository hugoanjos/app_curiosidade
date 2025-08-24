import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int totalCadastros;
  final int cadastrosUltimoMes;
  final int cadastrosPendentes;
  final bool isLoading;
  final String? error;
  final List<dynamic> recentes;

  const DashboardState({
    this.totalCadastros = 0,
    this.cadastrosUltimoMes = 0,
    this.cadastrosPendentes = 0,
    this.isLoading = false,
    this.error,
    this.recentes = const [],
  });

  DashboardState copyWith({
    int? totalCadastros,
    int? cadastrosUltimoMes,
    int? cadastrosPendentes,
    bool? isLoading,
    String? error,
    List<dynamic>? recentes,
  }) {
    return DashboardState(
      totalCadastros: totalCadastros ?? this.totalCadastros,
      cadastrosUltimoMes: cadastrosUltimoMes ?? this.cadastrosUltimoMes,
      cadastrosPendentes: cadastrosPendentes ?? this.cadastrosPendentes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      recentes: recentes ?? this.recentes,
    );
  }

  @override
  List<Object?> get props => [
        totalCadastros,
        cadastrosUltimoMes,
        cadastrosPendentes,
        isLoading,
        error,
        recentes,
      ];
}
