import 'package:app_curiosidade/features/dashboard/domain/usecases/get_dashboard_usecase.dart';
import 'package:app_curiosidade/features/dashboard/domain/usecases/get_recentes_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';
import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';
import 'package:app_curiosidade/shared/components/card_pessoa.dart';
import 'package:app_curiosidade/features/pessoas/presentation/pessoas_filter_cubit.dart';
import 'package:app_curiosidade/features/home/presentation/navigation_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<DashboardBloc>().add(RefreshDashboard());
    context.read<DashboardBloc>().add(LoadRecentes());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DashboardBloc(sl<GetDashboardUsecase>(), sl<GetRecentesUsecase>()),
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<DashboardBloc>().add(LoadDashboard());
            context.read<DashboardBloc>().add(LoadRecentes());
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
                        const SizedBox(height: 24),
                        const Text('Cadastros Recentes',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        if (state.recentes.isEmpty)
                          const Center(
                              child: Text('Nenhum cadastro recente encontrado'))
                        else
                          ...state.recentes.map((pessoa) => CardPessoa(
                                pessoa: pessoa,
                                showActions: false,
                                onTap: () {
                                  context
                                      .read<PessoasFilterCubit>()
                                      .setFilter(pessoa.email);
                                  context
                                      .read<NavigationCubit>()
                                      .selectTab(1); // Pessoas tab
                                },
                              ))
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
