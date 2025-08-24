import 'package:flutter_bloc/flutter_bloc.dart';

class PessoasFilterCubit extends Cubit<String?> {
  PessoasFilterCubit() : super(null);

  void setFilter(String? filter) => emit(filter);
  void clearFilter() => emit(null);
}
