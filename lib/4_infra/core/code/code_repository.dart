import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/core/failure.dart';

class CodeRepository extends ICodeRepository {
  final _conn = Get.find<IConnection>();

  final _cache = <CodeKey, List<Code>>{};

  @override
  Future<Either<Failure, List<Code>>> getCode(CodeKey codeKey) async {
    try {
      if (_cache.containsKey(codeKey)) {
        return right(_cache[codeKey]!);
      }
      const path = '/api/common/code';
      final ret = await _conn.get(path, {'key': codeKey.key});
      return ret.fold((l) => left(l), (r) {
        final codeList =
            (r as Iterable).map((json) => Code.fromJson(json)).toList();
        _cache[codeKey] = codeList;
        return right(codeList);
      });
    } catch (_) {
      return left(const Failure.fetchCodeFail("필요한 코드를 가져오는데 실패하였습니다."));
    }
  }
}
