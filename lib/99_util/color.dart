import 'dart:async';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class MakePaletteParam {
  final String imageUrl;
  final Rect region;
  final Size size;

  MakePaletteParam({
    required this.imageUrl,
    required this.region,
    required this.size,
  });
}

class BackgroundColorComputeResult {
  final bool isNeedToBeWhiteText;
  final Color backgroundColor;

  BackgroundColorComputeResult(
      {required this.isNeedToBeWhiteText, required this.backgroundColor});
}

bool isNeedToBeWhiteText(Color backgroundColor) {
  return backgroundColor.computeLuminance() < 0.5;
}

Future<PaletteGenerator> _makePaletteGenerator(MakePaletteParam param) async {
  final image = ExtendedNetworkImageProvider(param.imageUrl);
  final gen = await PaletteGenerator.fromImageProvider(image,
      size: param.size, region: param.region);
  return gen;
}

Future<BackgroundColorComputeResult?> calcBackgroundImage(
    MakePaletteParam param) async {
  try {
    final gen = await _makePaletteGenerator(param);
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
