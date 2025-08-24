import '../entities/pessoa.dart';
import '../../data/pessoas_repository.dart';

class CriarPessoaUsecase {
  final PessoasRepository repository;
  CriarPessoaUsecase(this.repository);

  Future<void> call(Pessoa pessoa, String token) async {
    await repository.criarCadastro(pessoa, token);
  }
}
