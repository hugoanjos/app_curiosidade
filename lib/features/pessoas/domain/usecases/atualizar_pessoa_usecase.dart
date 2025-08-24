import '../entities/pessoa.dart';
import '../../data/pessoas_repository.dart';

class AtualizarPessoaUsecase {
  final PessoasRepository repository;
  AtualizarPessoaUsecase(this.repository);

  Future<void> call(Pessoa pessoa, String token) async {
    await repository.editarCadastro(pessoa, token);
  }
}
