import 'package:dio/dio.dart';
import '../domain/entities/usuario.dart';

class LoginRepository {
  final Dio dio;
  LoginRepository(this.dio);

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

  Future<Map<String, dynamic>?> loginUsuario(String email, String senha) async {
    try {
      final response = await dio.post(
        '/usuario/login',
        data: {
          "Email": email,
          "Senha": senha,
        },
      );
      if (response.statusCode == 200) {
        return {
          'token': response.data['token'],
          'id': response.data['id'],
          'nome': response.data['nome'],
        };
      } else {
        throw Exception(response.data['error'] ?? 'Erro desconhecido');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
