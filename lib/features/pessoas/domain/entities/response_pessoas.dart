import 'pessoa.dart';

class ResponsePessoas {
  final List<Pessoa> pessoas;
  final int statusCode;
  final String message;

  ResponsePessoas({
    required this.pessoas,
    required this.statusCode,
    required this.message,
  });
}
