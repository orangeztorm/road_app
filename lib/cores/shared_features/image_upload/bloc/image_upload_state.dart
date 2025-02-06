part of 'image_upload_bloc.dart';

enum ImageUploadStatus { initial, success, failure, loading }

extension ImageUploadStatusX on ImageUploadStatus {
  bool get isInitial => this == ImageUploadStatus.initial;
  bool get isSuccess => this == ImageUploadStatus.success;
  bool get isFailure => this == ImageUploadStatus.failure;
  bool get isLoading => this == ImageUploadStatus.loading;
}

class ImageUploadState extends Equatable {
  const ImageUploadState({
    this.status = ImageUploadStatus.initial,
    this.failures,
    this.imageUrl,
  });

  final ImageUploadStatus status;
  final Failures? failures;
  final String? imageUrl;

  factory ImageUploadState.initial() => const ImageUploadState();

  ImageUploadState copyWith({
    ImageUploadStatus? status,
    Failures? failures,
    String? imageUrl,
  }) {
    return ImageUploadState(
      status: status ?? this.status,
      failures: failures ?? this.failures,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [status, failures, imageUrl];
}
