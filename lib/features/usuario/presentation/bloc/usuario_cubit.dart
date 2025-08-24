import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_curiosidade/features/usuario/domain/usecases/alterar_senha_usecase.dart';
import 'package:app_curiosidade/core/di.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';
import 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  final AlterarSenhaUsecase alterarSenhaUsecase;
  UsuarioCubit(this.alterarSenhaUsecase) : super(const UsuarioState());

  Future<void> alterarSenha(
      {required int id, required String novaSenha}) async {
    final token = sl<AuthCubit>().state.token ?? '';
    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));
    final result = await alterarSenhaUsecase.execute(
        id: id, novaSenha: novaSenha, token: token);
    if (result == null) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else {
      emit(state.copyWith(isLoading: false, error: result));
    }
  }
}
