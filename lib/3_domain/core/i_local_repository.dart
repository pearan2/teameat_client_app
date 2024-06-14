import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/local.dart';

abstract class ILocalRepository {
  Future<Either<Failure, List<Local>>> findLocal(String searchText);
}
