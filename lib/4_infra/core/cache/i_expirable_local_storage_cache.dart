abstract class IExpirableLocalStorageCache<T> {
  /// must unique
  late final String key;

  Duration get expireDuration;
  String Function(T value) get toJson;
  T Function(String) get fromJson;
  T? find();
  Future<bool> set(T value);
}
