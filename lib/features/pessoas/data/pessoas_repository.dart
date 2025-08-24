import 'package:dio/dio.dart';
import '../domain/entities/pessoa.dart';
import '../domain/entities/response_pessoas.dart';

class PessoasRepository {
  final Dio dio;
  PessoasRepository(this.dio);

  Future<ResponsePessoas> buscarPessoas(String busca, String token) async {
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
        return ResponsePessoas(
          pessoas: (response.data as List)
              .map((json) => Pessoa.fromJson(json))
              .toList(),
          statusCode: 200,
          message: '',
        );
      } else {
        return ResponsePessoas(
          pessoas: [],
          statusCode: response.statusCode ?? -1,
          message: response.data['error']?.toString() ?? 'Erro desconhecido',
        );
      }
    } catch (e) {
      return ResponsePessoas(
        pessoas: [],
        statusCode: -1,
        message: 'Erro ao buscar pessoas',
      );
    }
  }
}
