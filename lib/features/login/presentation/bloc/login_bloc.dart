import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/features/login/domain/usecases/login_usuario_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsuarioUsecase loginUsuarioUsecase;

  LoginBloc({LoginUsuarioUsecase? usecase})
      : loginUsuarioUsecase = usecase ?? sl<LoginUsuarioUsecase>(),
        super(const LoginState()) {
    on<LoginFormChanged>((event, emit) {
      final isValid = event.email.isNotEmpty && event.senha.isNotEmpty;
      emit(state.copyWith(isFormValid: isValid, error: null));
    });

    on<LoginRequested>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        final result =
            await loginUsuarioUsecase.execute(event.email, event.password);
        if (result != null &&
            result['token'] != null &&
            result['id'] != null &&
            result['nome'] != null) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            token: result['token'] as String?,
            id: result['id'] is int
                ? result['id'] as int
                : int.tryParse(result['id'].toString()),
            nome: result['nome'] as String?,
          ));
        } else {
          emit(state.copyWith(
              isLoading: false, error: 'Dados de login não recebidos'));
        }
      } catch (e) {
        emit(state.copyWith(
            isLoading: false,
            error: e.toString().replaceAll('Exception: ', '')));
      }
    });
  }
}
