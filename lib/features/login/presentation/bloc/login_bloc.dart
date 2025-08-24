import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/features/login/data/login_repository.dart';
import 'package:app_curiosidade/features/login/domain/usecases/login_usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsuarioUsecase loginUsuarioUsecase;

  LoginBloc({LoginUsuarioUsecase? usecase})
      : loginUsuarioUsecase =
            usecase ?? LoginUsuarioUsecase(sl<LoginRepository>()),
        super(const LoginState()) {
    on<LoginFormChanged>((event, emit) {
      final isValid = event.email.isNotEmpty && event.senha.isNotEmpty;
      emit(state.copyWith(isFormValid: isValid, error: null));
    });

    on<LoginRequested>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        final token =
            await loginUsuarioUsecase.execute(event.email, event.password);
        if (token != null) {
          emit(state.copyWith(isLoading: false, isSuccess: true, token: token));
        } else {
          emit(state.copyWith(isLoading: false, error: 'Token não recebido'));
        }
      } catch (e) {
        emit(state.copyWith(
            isLoading: false,
            error: e.toString().replaceAll('Exception: ', '')));
      }
    });
  }
}
