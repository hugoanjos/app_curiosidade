import 'package:app_curiosidade/core/config/app_config.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

void setupInjector() {
  sl.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl)));
}
