import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/4_infra/core/cache/i_expirable_local_storage_cache.dart';

mixin ExpirableLocalStorageCacheMixin<T> on IExpirableLocalStorageCache<T> {
  final _pref = Get.find<SharedPreferences>();

  String get _setTimeKey => '${key}setTime';

  DateTime? _findLastSetTime() {
    final setTimeMillis = _pref.getInt(_setTimeKey);
    if (setTimeMillis == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(setTimeMillis);
  }

  @override
  Future<bool> clear() async {
    final successes =
        await Future.wait([_pref.remove(key), _pref.remove(_setTimeKey)]);
    return successes.map((success) => !success).isEmpty;
  }

  @override
  T? find() {
    try {
      final lastCacheSetTime = _findLastSetTime();

      // 한번도 set 된 적이 없다는 뜻
      if (lastCacheSetTime == null) {
        return null;
      }
      // 마지막으로 캐시를 세팅한 시간에 expiredDuration 을 더했는데도 지금보다 이전이라면 Expired 되었다는 뜻
      if (lastCacheSetTime.add(expireDuration).isBefore(DateTime.now())) {
        return null;
      }
      final jsonString = _pref.getString(key);
      if (jsonString == null) {
        return null;
      }
      return fromJson(jsonString);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> set(T value) async {
    try {
      final jsonString = toJson(value);
      final rets = await Future.wait([
        _pref.setInt(_setTimeKey, DateTime.now().millisecondsSinceEpoch),
        _pref.setString(key, jsonString),
      ]);
      return rets.where((r) => r).isEmpty;
    } catch (_) {
      return false;
    }
  }
}
