part of 'cav_schedules_bloc.dart';

sealed class CavSchedulesEvent extends Equatable {
  const CavSchedulesEvent();

  @override
  List<Object> get props => [];
}

class GetCavSchedules extends CavSchedulesEvent {
  final RequestParam param;

  const GetCavSchedules(this.param);

  @override
  List<Object> get props => [param];
}

class GetMoreCavSchedules extends CavSchedulesEvent {
  final RequestParam param;

  const GetMoreCavSchedules(this.param);

  @override
  List<Object> get props => [param];
}
