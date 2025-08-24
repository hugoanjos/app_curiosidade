import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_curiosidade/features/dashboard/domain/usecases/get_dashboard_usecase.dart';
import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUsecase getDashboardUsecase;
  DashboardBloc(this.getDashboardUsecase) : super(const DashboardState()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
      LoadDashboard event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final token = sl<AuthCubit>().state.token ?? '';
      final data = await getDashboardUsecase.execute(token);
      emit(state.copyWith(
        totalCadastros: data['TotalCadastros'] ?? 0,
        cadastrosUltimoMes: data['CadastrosUltimoMes'] ?? 0,
        cadastrosPendentes: data['CadastrosPendentes'] ?? 0,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onRefreshDashboard(
      RefreshDashboard event, Emitter<DashboardState> emit) async {
    add(LoadDashboard());
  }
}
