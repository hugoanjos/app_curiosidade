import 'package:app_curiosidade/features/dashboard/data/dashboard_repository.dart';
import 'package:app_curiosidade/features/dashboard/domain/usecases/get_dashboard_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';
import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _dashboardBloc;

  @override
  void initState() {
    super.initState();
    final token = context.read<AuthCubit>().state.token ?? '';
    final dashboardRepository = sl<DashboardRepository>();
    _dashboardBloc = DashboardBloc(
      GetDashboardUsecase(dashboardRepository),
    );
    _dashboardBloc.add(LoadDashboard(token));
  }

  @override
  void dispose() {
    _dashboardBloc.close();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    final token = context.read<AuthCubit>().state.token ?? '';
    _dashboardBloc.add(RefreshDashboard(token));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _dashboardBloc,
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            if (state.error == 'Exception: unauthorized') {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed('/login');
              });
              return const SizedBox.shrink();
            }
            return Center(child: Text(state.error!));
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildCard('Total Cadastros', state.totalCadastros),
                _buildCard('Cadastros Último Mês', state.cadastrosUltimoMes),
                _buildCard('Cadastros Pendentes', state.cadastrosPendentes),
              ],
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
