import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_over_lay_event.dart';
part 'loading_over_lay_state.dart';

class LoadingOverlayBloc
    extends Bloc<LoadingOverlayEvent, LoadingOverlayState> {
  LoadingOverlayBloc() : super(LoadingOverLayInitial()) {
    on<LoadingOverlayEvent>((event, emit) {});

    on<ShowLoadingOverlayEvent>((_, emit) => emit(LoadingOverLayLoading()));

    on<HideLoadingOverlayEvent>((_, emit) => emit(LoadingOverLayInitial()));
  }
}
