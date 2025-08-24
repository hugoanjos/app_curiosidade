import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final String? token;
  const AuthState({this.token});
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void setToken(String token) => emit(AuthState(token: token));
  void clearToken() => emit(const AuthState());
}
