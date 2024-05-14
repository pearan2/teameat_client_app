import 'package:dartz/dartz.dart';

typedef JsonMap = Map<String, dynamic>;

abstract class IConnection<T, F> {
  bool get isLogined;
  void setAuthentication(T token);
  void removeAuthentication();
  Future<Either<F, Object>> get(String path, JsonMap? params);
  Future<Either<F, Object>> put(String path, JsonMap params);
  Future<Either<F, Object>> post(String path, JsonMap params);
}
