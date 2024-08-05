import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;

class ImageComputeResult {
  final int width;
  final int height;
  final Uint8List bytes;
  final String contentType;

  ImageComputeResult({
    required this.width,
    required this.height,
    required this.bytes,
    required this.contentType,
  });

  factory ImageComputeResult.empty() {
    return ImageComputeResult(
      width: 0,
      height: 0,
      bytes: Uint8List(0),
      contentType: '',
    );
  }
}

class ImageResizeParameter {
  /// 대상 이미지 파일
  final File file;

  /// Width, height 중 긴쪽 기준
  final int sideMax;

  /// resize 후 quality
  final int quality;

  ///
  final double? ratio;

  ImageResizeParameter(this.file,
      {this.sideMax = 1024, this.quality = 100, this.ratio});
}

Future<ImageComputeResult> _resize(ImageResizeParameter param) async {
  final File file = param.file;
  final int sideMax = param.sideMax;
  final int quality = param.quality;

  final img.Image? image = img.decodeImage(file.readAsBytesSync());
  if (image == null) {
    throw "이미지를 불러오는 도중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
  }

  late final int cropWidth;
  late final int cropHeight;
  late final double ratio;

  ratio = param.ratio ?? image.width / image.height;

  if (image.width > image.height) {
    cropWidth = min((image.height * ratio).round(), image.width);
    cropHeight = (cropWidth / ratio).ceil();
  } else {
    cropHeight = min((image.width / ratio).round(), image.height);
    cropWidth = (cropHeight * ratio).ceil();
  }

  /// 이때 위에서 계산된 값이

  final img.Image croppedImage = img.copyCrop(
    image,
    x: ((image.width - cropWidth) / 2).ceil(),
    y: ((image.height - cropHeight) / 2).ceil(),
    width: cropWidth,
    height: cropHeight,
  );

  int? resizeWidth;
  int? resizeHeight;
  if (cropWidth > cropHeight) {
    resizeWidth = min(cropWidth, sideMax);
  } else {
    resizeHeight = min(cropHeight, sideMax);
  }

  final img.Image resizedImage = img.copyResize(
    croppedImage,
    width: resizeWidth,
    height: resizeHeight,
    maintainAspect: true,
  );

  return ImageComputeResult(
    width: resizedImage.width,
    height: resizedImage.height,
    bytes: img.encodeJpg(resizedImage, quality: quality),
    contentType: 'image/jpg',
  );
}

Future<ImageComputeResult> _compute(File file, {int quality = 85}) async {
  final img.Image? image = img.decodeImage(file.readAsBytesSync());
  if (image == null) {
    throw "이미지를 불러오는 도중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
  }

  return ImageComputeResult(
    width: image.width,
    height: image.height,
    bytes: img.encodeJpg(image, quality: quality),
    contentType: 'image/jpg',
  );
}

Future<ImageComputeResult> computeAsync(File imageFile) async {
  return _compute(imageFile);
}

Future<ImageComputeResult> resizeAsync(ImageResizeParameter param) async {
  return compute(_resize, param);
}
