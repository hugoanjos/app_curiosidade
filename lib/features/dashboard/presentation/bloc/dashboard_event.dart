import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {
  final String token;
  LoadDashboard(this.token);

  @override
  List<Object?> get props => [token];
}

class RefreshDashboard extends DashboardEvent {
  final String token;
  RefreshDashboard(this.token);

  @override
  List<Object?> get props => [token];
}
