import 'package:dartz/dartz.dart';

typedef JsonMap = Map<String, dynamic>;

abstract class IConnection<T, F> {
  void setAuthentication(T token);
  void removeAuthentication();
  Future<Either<F, JsonMap>> get(String path, JsonMap params);
  Future<Either<F, JsonMap>> put(String path, JsonMap params);
  Future<Either<F, JsonMap>> post(String path, JsonMap params);
}
