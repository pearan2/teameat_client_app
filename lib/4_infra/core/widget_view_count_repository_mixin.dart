import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/3_domain/core/i_widget_view_count_repository.dart';

mixin WidgetViewCountRepositoryMixin<T extends Widget>
    on IWidgetViewCountRepository<T> {
  final _pref = Get.find<SharedPreferences>();

  String _getKey() {
    return T.toString();
  }

  int _view() {
    final key = _getKey();
    final viewCount = _pref.getInt(key) ?? 0;
    _pref.setInt(key, viewCount + 1);
    return viewCount;
  }

  @override
  bool get isNeverViewed => _view() == 0;
}
