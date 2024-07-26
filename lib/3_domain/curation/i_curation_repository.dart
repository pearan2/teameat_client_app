import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/i_likable_repository.dart';
import 'package:teameat/3_domain/curation/curation.dart';

abstract class ICurationRepository<T> extends ILikableRepository<T> {
  Future<Either<Failure, MyCurationDetail>> registerCuration(
      CurationCreateRequest request);

  Future<Either<Failure, MyCurationDetail>> findById(int id);

  Future<Either<Failure, List<MyCurationSimple>>> findAll(
      SearchMyCurationSimpleList searchOption);

  Future<Either<Failure, List<CurationListSimple>>> findCurationList(
      SearchCurationSimpleList searchOption);
}
