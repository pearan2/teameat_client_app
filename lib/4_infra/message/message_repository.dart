import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/message/i_message_repository.dart';
import 'package:teameat/4_infra/connection/connection.dart';

class MessageRepository extends IMessageRepository {
  final _conn = Get.find<HttpClient>();

  @override
  Future<Either<Failure, Unit>> saveToken(String token) async {
    try {
      const path = '/api/message-token';
      final ret = await _conn.put(path, {'token': token});
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (_) {
      return left(const Failure.requestFail("푸쉬 알림 토큰 저장에 실패했습니다."));
    }
  }
}
