import '../entities/response_pessoas.dart';
import '../../data/pessoas_repository.dart';

class BuscarPessoasUsecase {
  final PessoasRepository repository;
  BuscarPessoasUsecase(this.repository);

  Future<ResponsePessoas> execute(String busca, String token) async {
    return await repository.buscarPessoas(busca, token);
  }
}
