import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/99_util/image.dart';

abstract class IFileService {
  Future<Either<Failure, String>> uploadImageFile(File file);
  Future<Either<Failure, String>> uploadImage(ImageResizeResult image);
}
