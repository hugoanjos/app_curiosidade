import 'package:app_curiosidade/features/usuario/data/usuario_repository.dart';

class AlterarSenhaUsecase {
  final UsuarioRepository repository;
  AlterarSenhaUsecase(this.repository);

  Future<String?> execute(
      {required int id,
      required String novaSenha,
      required String token}) async {
    return await repository.alterarSenha(
        id: id, novaSenha: novaSenha, token: token);
  }
}
