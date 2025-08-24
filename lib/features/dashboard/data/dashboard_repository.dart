import 'package:dio/dio.dart';

class DashboardRepository {
  final Dio dio;
  DashboardRepository(this.dio);

  Future<Map<String, dynamic>> fetchDashboard(String token) async {
    try {
      final response = await dio.get(
        '/pessoa/dashboard',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('unauthorized');
      }
      final errorMsg = e.response?.data['error'] ?? 'Erro ao buscar dashboard';
      throw Exception(errorMsg);
    }
  }

  Future<List<dynamic>> fetchRecentes(String token) async {
    try {
      final response = await dio.get(
        '/pessoa/recentes',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('unauthorized');
      }
      final errorMsg = e.response?.data['error'] ?? 'Erro ao buscar recentes';
      throw Exception(errorMsg);
    }
  }
}
