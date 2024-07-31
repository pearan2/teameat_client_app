import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/i_likable_repository.dart';
import 'package:teameat/3_domain/curation/curation.dart';

abstract class ICurationRepository<T> extends ILikableRepository<T> {
  Future<Either<Failure, MyCurationDetail>> registerCuration(
      CurationCreateRequest request);

  Future<Either<Failure, MyCurationDetail>> findMyCurationById(int id);

  Future<Either<Failure, List<MyCurationSimple>>> findMyAllCurations(
      SearchMyCurationSimpleList searchOption);

  Future<Either<Failure, List<CurationListSimple>>> findAllCurations(
      SearchCurationSimpleList searchOption);

  Future<Either<Failure, CurationListDetail>> findCurationDetailById(int id);

  Future<Either<Failure, Unit>> updateCuration(
      int id, CurationCreateRequest request);

  Future<Either<Failure, Unit>> deleteCuration(int id);
}
