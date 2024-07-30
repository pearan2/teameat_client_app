import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/user/report/i_report_repository.dart';

class UserReportRepository implements IReportRepository {
  final _conn = Get.find<IConnection>();

  Future<Either<Failure, Unit>> _report(
    int targetId,
    String targetType,
    String? report,
  ) async {
    try {
      const path = '/api/member/report';
      final ret = await _conn.post(path,
          {'targetType': targetType, 'targetId': targetId, 'report': report});
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(const Failure.reportFail('신고에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> reportCuration(
      int curationId, String? report) async {
    return _report(curationId, "CURATION", report);
  }

  @override
  Future<Either<Failure, Unit>> reportUser(int userId, String? report) async {
    return _report(userId, "MEMBER", report);
  }
}
