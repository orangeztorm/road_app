part of 'add_to_schedule_bloc.dart';

sealed class AddToScheduleEvent extends Equatable {
  const AddToScheduleEvent();

  @override
  List<Object> get props => [];
}

class AddToSchedule extends AddToScheduleEvent {
  final RequestParam param;

  const AddToSchedule(this.param);

  @override
  List<Object> get props => [param];
}
