import 'package:dio/dio.dart';

class UsuarioRepository {
  final Dio dio;
  UsuarioRepository(this.dio);

  Future<String?> alterarSenha(
      {required int id,
      required String novaSenha,
      required String token}) async {
    try {
      final response = await dio.put(
        '/usuario/$id',
        data: {
          "Senha": novaSenha,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return null; // Success
      } else {
        return response.data['error'] ?? 'Erro desconhecido';
      }
    } catch (e) {
      return 'Erro ao alterar senha';
    }
  }
}
