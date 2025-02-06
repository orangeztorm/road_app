part of 'loading_over_lay_bloc.dart';

abstract class LoadingOverlayState extends Equatable {
  const LoadingOverlayState();

  @override
  List<Object> get props => [];
}

class LoadingOverLayInitial extends LoadingOverlayState {}

class LoadingOverLayLoading extends LoadingOverlayState {}
