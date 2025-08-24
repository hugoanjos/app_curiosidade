import '../../data/login_repository.dart';

class LoginUsuarioUsecase {
  final LoginRepository repository;
  LoginUsuarioUsecase(this.repository);

  Future<String?> execute(String email, String senha) async {
    return await repository.loginUsuario(email, senha);
  }
}
