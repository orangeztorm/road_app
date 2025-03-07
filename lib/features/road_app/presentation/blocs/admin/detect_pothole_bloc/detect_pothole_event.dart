part of 'detect_pothole_bloc.dart';

sealed class DetectPotholeEvent extends Equatable {
  const DetectPotholeEvent();

  @override
  List<Object> get props => [];
}

class DetectPothole extends DetectPotholeEvent {
  final RequestParam param;

  const DetectPothole(this.param);

  @override
  List<Object> get props => [param];
}
