import 'package:flutter/material.dart';

extension TETextStyleExtension on TextStyle {
  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle bold() {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle w500() {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle underLine() {
    return copyWith(decoration: TextDecoration.underline);
  }
}
