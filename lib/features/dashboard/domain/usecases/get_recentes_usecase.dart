import '../../data/dashboard_repository.dart';
import 'package:app_curiosidade/features/pessoas/domain/entities/pessoa.dart';

class GetRecentesUsecase {
  final DashboardRepository repository;
  GetRecentesUsecase(this.repository);

  Future<List<Pessoa>> execute(String token) async {
    final response = await repository.fetchRecentes(token);
    return (response).map((json) => Pessoa.fromJson(json)).toList();
  }
}
