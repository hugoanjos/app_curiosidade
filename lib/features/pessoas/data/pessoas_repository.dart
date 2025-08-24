import 'package:dio/dio.dart';
import '../domain/entities/pessoa.dart';
import '../domain/entities/response_pessoas.dart';

class PessoasRepository {
  Future<void> criarCadastro(Pessoa pessoa, String token) async {
    final body = {
      'Nome': pessoa.nome,
      'Idade': pessoa.idade,
      'Email': pessoa.email,
      'Endereco': pessoa.endereco,
      'OutrasInformacoes': pessoa.outrasInformacoes,
      'Interesses': pessoa.interesses,
      'Sentimentos': pessoa.sentimentos,
      'Valores': pessoa.valores,
      'Ativo': pessoa.ativo,
    };
    try {
      await dio.post(
        '/pessoa',
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Erro desconhecido');
    } catch (e) {
      throw Exception('Erro ao criar cadastro');
    }
  }

  Future<void> editarCadastro(Pessoa pessoa, String token) async {
    final body = {
      'Nome': pessoa.nome,
      'Idade': pessoa.idade,
      'Email': pessoa.email,
      'Endereco': pessoa.endereco,
      'OutrasInformacoes': pessoa.outrasInformacoes,
      'Interesses': pessoa.interesses,
      'Sentimentos': pessoa.sentimentos,
      'Valores': pessoa.valores,
      'Ativo': pessoa.ativo,
    };
    try {
      await dio.put(
        '/pessoa/${pessoa.id}',
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Erro desconhecido');
    } catch (e) {
      throw Exception('Erro ao editar cadastro');
    }
  }

  final Dio dio;
  PessoasRepository(this.dio);

  Future<ResponsePessoas> buscarPessoas(String busca, String token) async {
    try {
      final endpoint = (busca.isEmpty) ? '/pessoa' : '/pessoa/filtrar/$busca';
      final response = await dio.get(
        endpoint,
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
    } on DioException catch (e) {
      return ResponsePessoas(
        pessoas: [],
        statusCode: e.response?.statusCode ?? -1,
        message: e.response?.data['error']?.toString() ?? 'Erro desconhecido',
      );
    } catch (e) {
      return ResponsePessoas(
        pessoas: [],
        statusCode: -1,
        message: 'Erro ao buscar pessoas',
      );
    }
  }
}
