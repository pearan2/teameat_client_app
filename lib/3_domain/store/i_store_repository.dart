import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/store.dart';

abstract class IStoreRepository {
  Future<Either<Failure, List<StoreSimple>>> getStores(
      SearchStoreSimpleList searchOption);
}
