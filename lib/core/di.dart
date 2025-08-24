import 'package:app_curiosidade/core/config/app_config.dart';
import 'package:app_curiosidade/features/login/data/login_repository.dart';
import 'package:app_curiosidade/features/login/domain/usecases/login_usuario_usecase.dart';
import 'package:app_curiosidade/features/login/domain/usecases/cadastrar_usuario_usecase.dart';
import 'package:app_curiosidade/features/dashboard/domain/usecases/get_dashboard_usecase.dart';
import 'package:app_curiosidade/features/dashboard/domain/usecases/get_recentes_usecase.dart';
import 'package:app_curiosidade/features/pessoas/domain/usecases/buscar_pessoas_usecase.dart';
import 'package:app_curiosidade/features/usuario/domain/usecases/alterar_senha_usecase.dart';
import 'package:app_curiosidade/features/pessoas/data/pessoas_repository.dart';
import 'package:app_curiosidade/features/pessoas/domain/usecases/criar_pessoa_usecase.dart';
import 'package:app_curiosidade/features/pessoas/domain/usecases/atualizar_pessoa_usecase.dart';
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
  // Login
  sl.registerLazySingleton<LoginRepository>(() => LoginRepository(sl<Dio>()));
  sl.registerLazySingleton(() => LoginUsuarioUsecase(sl<LoginRepository>()));
  sl.registerLazySingleton(
      () => CadastrarUsuarioUsecase(sl<LoginRepository>()));
  // Dashboard
  sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepository(sl<Dio>()));
  sl.registerLazySingleton(
      () => GetDashboardUsecase(sl<DashboardRepository>()));
  sl.registerLazySingleton(() => GetRecentesUsecase(sl<DashboardRepository>()));
  // Usuário
  sl.registerLazySingleton<UsuarioRepository>(
      () => UsuarioRepository(sl<Dio>()));
  sl.registerLazySingleton(() => AlterarSenhaUsecase(sl<UsuarioRepository>()));
  // Pessoas
  sl.registerLazySingleton<PessoasRepository>(
      () => PessoasRepository(sl<Dio>()));
  sl.registerLazySingleton(() => BuscarPessoasUsecase(sl<PessoasRepository>()));
  sl.registerLazySingleton(() => CriarPessoaUsecase(sl<PessoasRepository>()));
  sl.registerLazySingleton(
      () => AtualizarPessoaUsecase(sl<PessoasRepository>()));
}
