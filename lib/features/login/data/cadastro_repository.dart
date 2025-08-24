import 'package:dio/dio.dart';
import 'package:app_curiosidade/core/di.dart';
import '../domain/entities/usuario.dart';

class CadastroRepository {
  final Dio dio = sl<Dio>();

  Future<String?> cadastrarUsuario(Usuario usuario) async {
    try {
      final response = await dio.post(
        '/usuario',
        data: {
          "Nome": usuario.nome,
          "Email": usuario.email,
          "Senha": usuario.senha,
        },
      );
      if (response.statusCode == 201) {
        return null; // Success
      } else {
        return response.data['error'] ?? 'Erro desconhecido';
      }
    } catch (e) {
      return 'Erro ao cadastrar usuário';
    }
  }
}
