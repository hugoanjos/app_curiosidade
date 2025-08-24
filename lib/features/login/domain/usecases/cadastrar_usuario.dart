import '../entities/usuario.dart';
import '../../data/cadastro_repository.dart';

class CadastrarUsuarioUsecase {
  final CadastroRepository repository;
  CadastrarUsuarioUsecase(this.repository);

  Future<String?> execute(Usuario usuario) async {
    return await repository.cadastrarUsuario(usuario);
  }
}
