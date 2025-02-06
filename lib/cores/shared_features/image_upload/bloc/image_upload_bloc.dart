import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';

part 'image_upload_event.dart';
part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  final ImageUploadUsecase imageUploadUsecase;
  ImageUploadBloc({
    required this.imageUploadUsecase,
  }) : super(ImageUploadState.initial()) {
    on<ImageUpload>(_onImageUpload);
  }

  Future<void> _onImageUpload(
    ImageUpload event,
    Emitter<ImageUploadState> emit,
  ) async {
    emit(state.copyWith(status: ImageUploadStatus.loading));
    final result = await imageUploadUsecase.call(event.param);
    result.fold(
      (l) => emit(state.copyWith(
        status: ImageUploadStatus.failure,
        failures: l,
      )),
      (r) => emit(state.copyWith(
        status: ImageUploadStatus.success,
        imageUrl: r.data,
      )),
    );
  }
}
