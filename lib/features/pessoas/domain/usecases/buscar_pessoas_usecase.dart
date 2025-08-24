import '../entities/pessoa.dart';
import '../../data/pessoas_repository.dart';

class BuscarPessoasUsecase {
  final PessoasRepository repository;
  BuscarPessoasUsecase(this.repository);

  Future<List<Pessoa>> execute(String busca, String token) async {
    return await repository.buscarPessoas(busca, token);
  }
}
