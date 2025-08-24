import 'package:dio/dio.dart';
import '../domain/entities/pessoa.dart';

class PessoasRepository {
  final Dio dio;
  PessoasRepository(this.dio);

  Future<List<Pessoa>> buscarPessoas(String busca, String token) async {
    try {
      final response = await dio.get(
        '/pessoa/$busca',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => Pessoa.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
