import 'dart:developer';
import 'dart:io';
import 'package:uni_storage/uni_storage.dart';
import 'package:road_app/app/__app.dart';

import '../../../../entity/base_entity.dart';
import '../../../../exception/base_exception.dart';
import '../../../../utils/__utils.dart';

abstract class ImageUploadRemoteDataSource {
  Future<BaseModel> uploadImage(String imagePath);
  Future<List<BaseModel>> uploadMultipleImage(List<String> pathList);
}

class ImageUploadRemoteDataSourceImpl extends ImageUploadRemoteDataSource {
  ImageUploadRemoteDataSourceImpl();

  @override
  Future<BaseModel> uploadImage(String imagePath) async {
    final File docFile = File(imagePath);
    final ENV env = getIt<ENV>();

    try {
      final String fileName = docFile.path.split('/').last;
      final String fileKey = 'images/$fileName'; // Customize the path as needed

      final String mimeType = getMimeType(imagePath);

      // Use the initialized UniStorage
      final response = await UniStorage.uniStorge!
          .bucket(env.digitalOceanProjectName)
          .uploadFile(fileKey, docFile, mimeType, Permissions.public);

      if (response != null) {
        log('Upload successful ${env.digitalOceanBucketUrl}$fileKey');
        return BaseModel(
          state: "success",
          status: '202',
          message: "success",
          data: '${env.digitalOceanBucketUrl}$fileKey',
        );
      } else {
        LoggerHelper.log('Failed to upload: $response');
        throw BaseFailures(message: 'Failed to upload the image: $response');
      }
    } catch (err, s) {
      LoggerHelper.log(err, s);
      throw BaseFailures(
        message: 'An error occurred uploading the image: $err',
      );
    }
  }

  @override
  Future<List<BaseModel>> uploadMultipleImage(List<String> pathList) async {
    final List<BaseModel> imageUrls = await Future.wait(
      pathList.map((image) => uploadImage(image)),
    );

    return imageUrls;
  }
}
