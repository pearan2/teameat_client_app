import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/order/i_order_repository.dart';
import 'package:teameat/3_domain/order/order.dart' as dto;

class OrderRepository implements IOrderRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, dto.Order>> registerOrder(
      dto.RegisterOrderDto registerOrderDto,
      {bool isGroupBuying = false}) async {
    try {
      String path = '/api/order';
      if (isGroupBuying) {
        path += '/group-buying';
      }
      final ret = await _conn.post(path, registerOrderDto.toJson());
      return ret.fold(
          (l) => left(l), (r) => right(dto.Order.fromJson(r as JsonMap)));
    } catch (e) {
      return left(
          const Failure.registerOrderFail('주문 요청에 실패하였습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, List<dto.GroupBuying>>> findGroupBuy(
      int itemId) async {
    try {
      final path = '/api/order/group-buying/$itemId';
      final ret = await _conn.get(path, null);
      return ret.fold(
          (l) => left(l),
          (r) => right((r as Iterable)
              .map((json) => dto.GroupBuying.fromJson(json))
              .toList()));
    } catch (e) {
      return left(const Failure.fetchGroupBuyingFail(
          '현재 진행 중인 공동구매 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
