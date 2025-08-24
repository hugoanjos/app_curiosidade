import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_cubit.dart';
import 'package:app_curiosidade/features/dashboard/presentation/dashboard_page.dart';
import 'package:app_curiosidade/features/pessoas/presentation/pessoas_page.dart';
import 'package:app_curiosidade/features/pessoas/presentation/pessoas_filter_cubit.dart';
import 'package:app_curiosidade/features/usuario/presentation/usuario_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Widget> _pages(BuildContext context) => [
        const DashboardPage(),
        PessoasPage(initialSearch: context.watch<PessoasFilterCubit>().state),
        const UsuarioPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PessoasFilterCubit(),
      child: BlocProvider(
        create: (_) => NavigationCubit(),
        child: BlocBuilder<NavigationCubit, int>(
          builder: (context, selectedIndex) => Scaffold(
            body: _pages(context)[selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) =>
                  context.read<NavigationCubit>().selectTab(index),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: 'Cadastros'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Usuário'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
