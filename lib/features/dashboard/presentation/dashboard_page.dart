import 'package:app_curiosidade/features/dashboard/data/dashboard_repository.dart';
import 'package:app_curiosidade/features/dashboard/domain/usecases/get_dashboard_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';
import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<DashboardBloc>().add(RefreshDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DashboardBloc(GetDashboardUsecase(sl<DashboardRepository>())),
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<DashboardBloc>().add(LoadDashboard());
          });
          return Scaffold(
            appBar: AppBar(title: const Text('Dashboard')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.error != null) {
                    if (state.error == 'Exception: unauthorized') {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        sl<AuthCubit>().clearAuth();
                        Navigator.of(context).pushReplacementNamed('/login');
                      });
                      return const SizedBox.shrink();
                    }
                    return Center(child: Text(state.error!));
                  }
                  return RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: ListView(
                      children: [
                        _buildCard('Total Cadastros', state.totalCadastros),
                        _buildCard(
                            'Cadastros Último Mês', state.cadastrosUltimoMes),
                        _buildCard(
                            'Cadastros Pendentes', state.cadastrosPendentes),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, int value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        trailing: Text(value.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
