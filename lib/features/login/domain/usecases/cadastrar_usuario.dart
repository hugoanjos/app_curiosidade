import '../entities/usuario.dart';
import '../../data/login_repository.dart';

class CadastrarUsuarioUsecase {
  final LoginRepository repository;
  CadastrarUsuarioUsecase(this.repository);

  Future<String?> execute(Usuario usuario) async {
    return await repository.cadastrarUsuario(usuario);
  }
}
