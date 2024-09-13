import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/3_domain/core/i_need_action_repository.dart';

class NeedActionRepository implements INeedActionRepository {
  final _pref = Get.find<SharedPreferences>();

  String _getKey(TEAction action) {
    return "${action.name}actedAt";
  }

  @override
  bool isNeedTo(TEAction action) {
    final key = _getKey(action);
    final actedAtMillis = _pref.getInt(key);
    if (actedAtMillis == null) {
      return true;
    }
    final actedAt = DateTime.fromMillisecondsSinceEpoch(actedAtMillis);
    return actedAt.add(action.resetDuration).isBefore(DateTime.now());
  }

  @override
  void act(TEAction action) {
    _pref.setInt(_getKey(action), DateTime.now().millisecondsSinceEpoch);
  }
}
