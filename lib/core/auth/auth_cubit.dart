import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final String? token;
  final int? id;
  final String? nome;
  const AuthState({this.token, this.id, this.nome});
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void setAuth(
          {required String token, required int id, required String nome}) =>
      emit(AuthState(token: token, id: id, nome: nome));

  void clearAuth() => emit(const AuthState());
}
