import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class StoreItemRepository extends IStoreItemRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, ItemDetail>> findById(int id) async {
    try {
      final path = '/api/store/item/$id';
      final ret = await _conn.get(path, null);
      return ret.fold(
          (l) => left(l), (r) => right(ItemDetail.fromJson(r as JsonMap)));
    } catch (e) {
      return left(const Failure.fetchStoreItemFail(
          '상품 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
