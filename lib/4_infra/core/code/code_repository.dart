import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';

class CodeRepository implements ICodeRepository {
  final _conn = Get.find<IConnection>();

  final _codeCache = <CodeKey, List<Code>>{};
  List<SearchableAddress> _searchableAddressCache = <SearchableAddress>[];

  @override
  Future<Either<Failure, List<Code>>> getCode(CodeKey codeKey) async {
    try {
      if (_codeCache.containsKey(codeKey)) {
        return right(_codeCache[codeKey]!);
      }
      const path = '/api/common/code';
      final ret = await _conn.get(path, {'key': codeKey.key});
      return ret.fold((l) => left(l), (r) {
        final codeList =
            (r as Iterable).map((json) => Code.fromJson(json)).toList();
        _codeCache[codeKey] = codeList;
        return right(codeList);
      });
    } catch (_) {
      return left(const Failure.fetchCodeFail("필요한 코드를 가져오는데 실패하였습니다."));
    }
  }

  @override
  Future<Either<Failure, List<SearchableAddress>>>
      getSearchableAddress() async {
    try {
      if (_searchableAddressCache.isNotEmpty) {
        return right(_searchableAddressCache);
      }
      const path = '/api/common/address-filter';
      final ret = await _conn.get(path, null);
      return ret.fold((l) => left(l), (r) {
        final addresses = (r as Iterable)
            .map((json) => SearchableAddress.fromJson(json))
            .toList();
        _searchableAddressCache = addresses;
        return right(addresses);
      });
    } catch (_) {
      return left(const Failure.fetchCodeFail("필요한 코드를 가져오는데 실패하였습니다."));
    }
  }
}
