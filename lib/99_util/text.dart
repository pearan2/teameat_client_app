import 'package:flutter/material.dart';

TextPainter getTextPainter({
  int? maxLine,
  TextStyle? style,
  required String text,
  required double maxWidth,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLine,
    textDirection: TextDirection.ltr,
  )..layout(
      maxWidth: maxWidth,
    );
  return textPainter;
}
