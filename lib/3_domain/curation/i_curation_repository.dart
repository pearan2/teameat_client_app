import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';

abstract class ICurationRepository {
  Future<Either<Failure, CurationDetail>> registerCuration(
      CurationCreateRequest request);

  Future<Either<Failure, CurationDetail>> findById(int id);

  Future<Either<Failure, List<CurationSimple>>> findAll(
      {required int pageNumber, required int pageSize});
}
