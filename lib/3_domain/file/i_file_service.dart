import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class IFileService {
  Future<Either<Failure, String>> uploadImage(File file);
}
