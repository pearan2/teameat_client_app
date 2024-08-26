import 'package:flutter/material.dart';

extension TEWidgetExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
}
