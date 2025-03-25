part of 'complete_pothole_assesment_bloc.dart';

sealed class CompletePotholeAssesmentEvent extends Equatable {
  const CompletePotholeAssesmentEvent();

  @override
  List<Object> get props => [];
}

class CompletePotholeAssesment extends CompletePotholeAssesmentEvent {
  final RequestParam param;
  const CompletePotholeAssesment(this.param);

  @override
  List<Object> get props => [param];
}
