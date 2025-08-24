import 'package:app_curiosidade/features/login/domain/usecases/cadastrar_usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cadastro_event.dart';
import 'cadastro_state.dart';
import '../../../data/login_repository.dart';
import '../../../domain/entities/usuario.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  final CadastrarUsuarioUsecase cadastrarUsuarioUsecase;

  CadastroBloc({CadastrarUsuarioUsecase? usecase})
      : cadastrarUsuarioUsecase =
            usecase ?? CadastrarUsuarioUsecase(sl<LoginRepository>()),
        super(const CadastroState()) {
    on<CadastroFormChanged>((event, emit) {
      final isValid = event.nome.isNotEmpty &&
          event.email.isNotEmpty &&
          event.senha.isNotEmpty;
      emit(state.copyWith(isFormValid: isValid, error: null));
    });

    on<CadastrarUsuario>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      final usuario = Usuario(
        nome: event.nome,
        email: event.email,
        senha: event.senha,
      );
      final error = await cadastrarUsuarioUsecase.execute(usuario);
      if (error == null) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, error: error));
      }
    });
  }
}
