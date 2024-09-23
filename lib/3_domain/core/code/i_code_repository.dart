import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';

abstract class ICodeRepository {
  Future<Either<Failure, List<Code>>> getCode(CodeKey codeKey);
  Future<Either<Failure, List<SearchableAddress>>> getSearchableAddress();
  Future<Either<Failure, List<SearchableAddress>>>
      getCurationSearchableAddress();
}
