import '../../data/dashboard_repository.dart';

class GetDashboardUsecase {
  final DashboardRepository repository;
  GetDashboardUsecase(this.repository);

  Future<Map<String, dynamic>> execute(String token) async {
    return await repository.fetchDashboard(token);
  }
}
