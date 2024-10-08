import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/i_likable_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';

abstract class IStoreRepository<T> extends ILikableRepository<T> {
  Future<Either<Failure, List<StoreSimple>>> getStores(
      SearchSimpleList searchOption);

  Future<Either<Failure, List<ItemSimple>>> getStoreItems(
      SearchSimpleList searchOption);

  Future<Either<Failure, StoreDetail>> getStoreDetail(int storeId);
  Future<Either<Failure, bool>> isStoreEntered(String storeId);
}
