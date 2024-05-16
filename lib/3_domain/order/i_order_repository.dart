import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/order/order.dart' as dto;

abstract class IOrderRepository {
  Future<Either<Failure, dto.Order>> registerOrder(
      dto.RegisterOrderDto registerOrderDto);
}
