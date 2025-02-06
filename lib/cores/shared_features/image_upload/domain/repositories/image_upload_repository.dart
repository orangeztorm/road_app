import 'package:fpdart/fpdart.dart';

import '../../../../entity/base_entity.dart';
import '../../../../failures/base.dart';

abstract class ImageUploadRepository {
  Future<Either<Failures, BaseEntity>> uploadImage(String imagePath);

  Future<Either<Failures, List<BaseEntity>>> uploadMultipleImage(
    List<String> pathList,
  );
}
