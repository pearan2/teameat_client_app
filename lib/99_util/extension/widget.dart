import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension TEWidgetExtension on Widget {
  Widget obx() {
    return Obx(() => this);
  }
}
