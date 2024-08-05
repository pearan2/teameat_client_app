import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class BackgroundColorComputeResult {
  final bool isNeedToBeWhiteText;
  final Color backgroundColor;

  BackgroundColorComputeResult(
      {required this.isNeedToBeWhiteText, required this.backgroundColor});
}

bool isNeedToBeWhiteText(Color backgroundColor) {
  return backgroundColor.computeLuminance() < 0.5;
}

Future<PaletteGenerator> _makePaletteGenerator(String imageUrl) async {
  const width = 128.0;
  const height = 128.0;
  const calcRegionHeightRatio = 0.2;

  final image = ResizeImage(ExtendedNetworkImageProvider(imageUrl),
      width: width.toInt(), height: height.toInt());
  final gen = await PaletteGenerator.fromImageProvider(
    image,
    size: const Size(width, height),
    region: const Rect.fromLTRB(0, 0, width, height * calcRegionHeightRatio),
  );
  return gen;
}

Future<BackgroundColorComputeResult?> calcBackgroundImage(
    String imageUrl) async {
  try {
    final gen = await _makePaletteGenerator(imageUrl);
    if (gen.dominantColor == null) {
      return null;
    }
    final dominantColor = gen.dominantColor!.color;
    return BackgroundColorComputeResult(
        isNeedToBeWhiteText: isNeedToBeWhiteText(dominantColor),
        backgroundColor: dominantColor);
  } catch (_) {
    return null;
  }
}
