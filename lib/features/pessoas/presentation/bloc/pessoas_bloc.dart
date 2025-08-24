import 'package:app_curiosidade/core/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pessoas_event.dart';
import 'pessoas_state.dart';
import '../../domain/usecases/buscar_pessoas_usecase.dart';
import '../../domain/usecases/criar_pessoa_usecase.dart';
import '../../domain/usecases/atualizar_pessoa_usecase.dart';
import 'package:app_curiosidade/core/auth/auth_cubit.dart';

class PessoasBloc extends Bloc<PessoasEvent, PessoasState> {
  final BuscarPessoasUsecase buscarPessoasUsecase;
  final CriarPessoaUsecase criarPessoaUsecase;
  final AtualizarPessoaUsecase atualizarPessoaUsecase;
  PessoasBloc({
    required this.buscarPessoasUsecase,
    required this.criarPessoaUsecase,
    required this.atualizarPessoaUsecase,
  }) : super(const PessoasState()) {
    on<BuscarPessoasEvent>(_onBuscarPessoas);
    on<CriarPessoaEvent>(_onCriarPessoa);
    on<AtualizarPessoaEvent>(_onAtualizarPessoa);
  }

  Future<void> _onBuscarPessoas(
      BuscarPessoasEvent event, Emitter<PessoasState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, success: null));
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

  Future<void> _onCriarPessoa(
      CriarPessoaEvent event, Emitter<PessoasState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, success: null));
    try {
      final token = sl<AuthCubit>().state.token ?? '';
      await criarPessoaUsecase.call(event.pessoa, token);
      emit(state.copyWith(isLoading: false, success: true));
      add(const BuscarPessoasEvent(''));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, error: e.toString(), success: false));
    }
  }

  Future<void> _onAtualizarPessoa(
      AtualizarPessoaEvent event, Emitter<PessoasState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, success: null));
    try {
      final token = sl<AuthCubit>().state.token ?? '';
      await atualizarPessoaUsecase.call(event.pessoa, token);
      emit(state.copyWith(isLoading: false, success: true));
      add(const BuscarPessoasEvent(''));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, error: e.toString(), success: false));
    }
  }
}
