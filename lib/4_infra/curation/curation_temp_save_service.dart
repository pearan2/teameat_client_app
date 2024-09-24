import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/3_domain/curation/i_curation_temp_save_service.dart';

class CurationTempSaveService implements ICurationTempSaveService {
  final _pref = Get.find<SharedPreferences>();

  static const _curationCreateJsonStringKey = 'curationTempSaveKey';

  @override
  Future<bool> clear() {
    return _pref.remove(_curationCreateJsonStringKey);
  }

  @override
  CurationCreate findTempSave() {
    try {
      final jsonString = _pref.getString(_curationCreateJsonStringKey);
      if (jsonString == null) {
        return CurationCreate.empty();
      }
      return CurationCreate.fromJson(jsonDecode(jsonString));
    } catch (_) {
      // 한번이라도 실패하면 자체적으로 clear 해준다
      clear();
      return CurationCreate.empty();
    }
  }

  @override
  bool isTempSaveExists() {
    final tempSaved = findTempSave();
    return !tempSaved.isEmpty;
  }

  @override
  Future<bool> tempSave(CurationCreate curationCreate) async {
    try {
      return _pref.setString(
          _curationCreateJsonStringKey, jsonEncode(curationCreate.toJson()));
    } catch (_) {
      return false;
    }
  }
}
