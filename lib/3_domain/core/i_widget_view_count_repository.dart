import 'package:flutter/material.dart';

abstract class IWidgetViewCountRepository<T extends Widget> {
  bool get isNeverViewed;
}
