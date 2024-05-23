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
      dto.RegisterOrderDto registerOrderDto) async {
    try {
      const path = '/api/order';
      final ret = await _conn.post(path, registerOrderDto.toJson());
      return ret.fold(
          (l) => left(l), (r) => right(dto.Order.fromJson(r as JsonMap)));
    } catch (e) {
      return left(
          const Failure.registerOrderFail('주문 요청에 실패하였습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
