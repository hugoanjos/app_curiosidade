import 'package:app_curiosidade/core/config/app_config.dart';
import 'package:app_curiosidade/features/login/data/login_repository.dart';
import 'package:app_curiosidade/features/pessoas/data/pessoas_repository.dart';
import 'package:app_curiosidade/features/usuario/data/usuario_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:app_curiosidade/features/dashboard/data/dashboard_repository.dart';
import 'package:dio/dio.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';

final sl = GetIt.instance;

void setupInjector() {
  sl.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl)));
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit());
  sl.registerLazySingleton<LoginRepository>(() => LoginRepository(sl<Dio>()));
  sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepository(sl<Dio>()));
  sl.registerLazySingleton<UsuarioRepository>(
      () => UsuarioRepository(sl<Dio>()));
  sl.registerLazySingleton<PessoasRepository>(
      () => PessoasRepository(sl<Dio>()));
}
