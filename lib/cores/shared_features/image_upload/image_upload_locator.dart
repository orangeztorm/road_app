import 'package:road_app/cores/shared_features/image_upload/bloc/image_upload_bloc.dart';

import '../../../app/locator.dart';
import 'data/datasources/image_upload_remote_data_source.dart';
import 'data/repositories/image_upload_repository_impl.dart';
import 'domain/repositories/image_upload_repository.dart';
import 'domain/usecases/image_upload_usecase.dart';
import 'domain/usecases/upload_multiple_image_usecase.dart';

void setUpImageUploadLocator() {
  /// data source
  getIt.registerLazySingleton<ImageUploadRemoteDataSource>(
    () => ImageUploadRemoteDataSourceImpl(),
  );

  // repository
  getIt.registerLazySingleton<ImageUploadRepository>(
    () => ImageUploadRepositoryImpl(imageUploadRemoteDataSource: getIt()),
  );

  // usecase
  getIt.registerLazySingleton<ImageUploadUsecase>(
    () => ImageUploadUsecase(getIt()),
  );

  getIt.registerLazySingleton<ImageMultipleUploadUsecase>(
    () => ImageMultipleUploadUsecase(getIt()),
  );

  getIt.registerFactory<ImageUploadBloc>(
    () => ImageUploadBloc(imageUploadUsecase: getIt()),
  );
}
