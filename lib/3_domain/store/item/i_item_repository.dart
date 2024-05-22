import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/item/item.dart';

abstract class IStoreItemRepository {
  Future<Either<Failure, ItemDetail>> findById(int id);
  Future<Either<Failure, List<ItemSimple>>> findRecentSeeItems();
  Future<Either<Failure, List<ItemSimple>>> findRecommendedItems(
      int numberOfItems);
  Future<Either<Failure, List<ItemSimple>>> findLikeItems(int pageNumber);

  void like(int id);
  void unlike(int id);
  List<int> findMyLikes();
}
