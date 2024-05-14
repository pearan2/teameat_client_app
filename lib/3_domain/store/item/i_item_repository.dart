import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/item/item.dart';

abstract class IStoreItemRepository {
  Future<Either<Failure, ItemDetail>> findById(int id);
}
