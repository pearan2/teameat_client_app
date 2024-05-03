import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class IMessageRepository {
  Future<Either<Failure, Unit>> saveToken(String token);
}
