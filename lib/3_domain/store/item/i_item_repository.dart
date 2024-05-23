import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/i_likable_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';

abstract class IStoreItemRepository<T> extends ILikableRepository<T> {
  Future<Either<Failure, ItemDetail>> findById(int id);
  Future<Either<Failure, List<ItemSimple>>> findRecentSeeItems();
  Future<Either<Failure, List<ItemSimple>>> findRecommendedItems(
      int numberOfItems);
}
