import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class ILikableRepository<T> {
  int get numberOfLikeDatasPerPage;
  Future<Either<dynamic, Object>> Function(List<int> ids) get dataLoader;
  T Function(JsonMap json) get dataResolver;
  String get likeLoadPath;
  String Function(int id) get likeCallbackPathBuilder;
  String Function(int id) get unlikeCallbackPathBuilder;
  String get key;

  Future<List<int>> loadLikes();
  Future<Either<Failure, List<T>>> findLikeData(int pageNumber);

  void like(int id);
  void unlike(int id);
}
