import 'package:flutter/material.dart';

extension TEStringExtension on String {
  Text style(TextStyle style, {TextAlign? textAlign}) {
    return Text(this, style: style, textAlign: textAlign);
  }
}
