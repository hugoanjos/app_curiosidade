import 'package:app_curiosidade/features/login/domain/usecases/cadastrar_usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cadastro_event.dart';
import 'cadastro_state.dart';
import '../../../data/cadastro_repository.dart';
import '../../../domain/entities/usuario.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  final CadastrarUsuarioUsecase cadastrarUsuarioUsecase;

  CadastroBloc({CadastrarUsuarioUsecase? usecase})
      : cadastrarUsuarioUsecase =
            usecase ?? CadastrarUsuarioUsecase(CadastroRepository()),
        super(CadastroInitial()) {
    on<CadastrarUsuario>((event, emit) async {
      emit(CadastroLoading());
      final usuario = Usuario(
        nome: event.nome,
        email: event.email,
        senha: event.senha,
      );
      final error = await cadastrarUsuarioUsecase.execute(usuario);
      if (error == null) {
        emit(CadastroSuccess());
      } else {
        emit(CadastroError(error));
      }
    });
  }
}
