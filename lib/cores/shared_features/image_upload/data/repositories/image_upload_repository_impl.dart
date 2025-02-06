import 'package:fpdart/fpdart.dart';

import '../../../../entity/base_entity.dart';
import '../../../../failures/base.dart';
import '../../../../try_catch_helper/try_catch_helper.dart';
import '../../domain/repositories/image_upload_repository.dart';
import '../datasources/image_upload_remote_data_source.dart';

class ImageUploadRepositoryImpl extends ImageUploadRepository {
  final ImageUploadRemoteDataSource _imageUploadRemoteDataSource;

  ImageUploadRepositoryImpl({
    required ImageUploadRemoteDataSource imageUploadRemoteDataSource,
  }) : _imageUploadRemoteDataSource = imageUploadRemoteDataSource;

  @override
  Future<Either<Failures, BaseEntity>> uploadImage(String imagePath) async {
    final action = _imageUploadRemoteDataSource.uploadImage(imagePath);

    final repoTryCatchHelper = RepoTryCatchHelper<BaseEntity>();
    return await repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, List<BaseEntity>>> uploadMultipleImage(
    List<String> pathList,
  ) async {
    final action = _imageUploadRemoteDataSource.uploadMultipleImage(pathList);

    final repoTryCatchHelper = RepoTryCatchHelper<List<BaseEntity>>();
    return await repoTryCatchHelper.tryAction(() => action);
  }
}
