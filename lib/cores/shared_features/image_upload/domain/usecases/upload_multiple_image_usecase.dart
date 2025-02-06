import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../entity/base_entity.dart';
import '../../../../failures/base.dart';
import '../../../../usecase/usecase_interface.dart';
import '../repositories/image_upload_repository.dart';

class ImageMultipleUploadUsecase extends UseCaseFuture<Failures,
    List<BaseEntity>, ImageMultipleUploadParams> {
  final ImageUploadRepository _imageUploadRepository;

  ImageMultipleUploadUsecase(this._imageUploadRepository);

  @override
  Future<Either<Failures, List<BaseEntity>>> call(
    ImageMultipleUploadParams params,
  ) async {
    return await _imageUploadRepository.uploadMultipleImage(params.pathList);
  }
}

class ImageMultipleUploadParams extends Equatable {
  final List<String> pathList;

  const ImageMultipleUploadParams(this.pathList);

  @override
  List<Object?> get props => [pathList];
}
