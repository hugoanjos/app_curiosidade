import 'package:app_curiosidade/features/login/presentation/bloc/cadastro/cadastro_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pessoas_event.dart';
import 'pessoas_state.dart';
import '../../domain/usecases/buscar_pessoas_usecase.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';

class PessoasBloc extends Bloc<PessoasEvent, PessoasState> {
  final BuscarPessoasUsecase buscarPessoasUsecase;
  PessoasBloc(this.buscarPessoasUsecase) : super(const PessoasState()) {
    on<BuscarPessoasEvent>(_onBuscarPessoas);
  }

  Future<void> _onBuscarPessoas(
      BuscarPessoasEvent event, Emitter<PessoasState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final token = sl<AuthCubit>().state.token ?? '';
      final response = await buscarPessoasUsecase.execute(event.busca, token);
      if (response.statusCode == 200) {
        emit(state.copyWith(isLoading: false, response: response));
      } else {
        emit(state.copyWith(
            isLoading: false, response: response, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
