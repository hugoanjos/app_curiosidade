import 'package:dio/dio.dart';
import 'package:app_curiosidade/core/di.dart';
import '../domain/entities/usuario.dart';

class LoginRepository {
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

  Future<String?> loginUsuario(String email, String senha) async {
    try {
      final response = await dio.post(
        '/usuario/login',
        data: {
          "Email": email,
          "Senha": senha,
        },
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception(response.data['error'] ?? 'Erro desconhecido');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
