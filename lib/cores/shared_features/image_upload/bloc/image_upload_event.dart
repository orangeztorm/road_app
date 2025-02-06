part of 'image_upload_bloc.dart';

sealed class ImageUploadEvent extends Equatable {
  const ImageUploadEvent();

  @override
  List<Object> get props => [];
}

class ImageUpload extends ImageUploadEvent {
  const ImageUpload(this.param);

  final ImageUploadParams param;

  @override
  List<Object> get props => [param];
}
