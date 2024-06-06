import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/file/i_file_service.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class ImageResizeResult {
  final int width;
  final int height;
  final Uint8List bytes;
  final String contentType;

  ImageResizeResult({
    required this.width,
    required this.height,
    required this.bytes,
    required this.contentType,
  });
}

class ImageResizeParameter {
  final File file;
  final int sideMax;
  final int quality;

  ImageResizeParameter(this.file, {this.sideMax = 1024, this.quality = 85});
}

Future<ImageResizeResult> _resize(ImageResizeParameter param) async {
  final File file = param.file;
  final int sideMax = param.sideMax;
  final int quality = param.quality;

  final img.Image? image = img.decodeImage(file.readAsBytesSync());
  if (image == null) {
    throw "이미지를 불러오는 도중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
  }

  late final int width;
  late final int height;

  if (image.width < sideMax && image.height < sideMax) {
    return ImageResizeResult(
      width: image.width,
      height: image.height,
      bytes: file.readAsBytesSync(),
      contentType: lookupMimeType(file.path)!,
    );
  }

  if (image.width > image.height) {
    width = sideMax;
    height = (image.height / image.width * sideMax).round();
  } else {
    height = sideMax;
    width = (image.width / image.height * sideMax).round();
  }

  final img.Image resizedImage =
      img.copyResize(image, width: width, height: height);

  return ImageResizeResult(
    width: width,
    height: height,
    bytes: img.encodeJpg(resizedImage, quality: quality),
    contentType: 'image/jpg',
  );
}

class FileService implements IFileService {
  static const imageSideMax = 1024;
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, String>> uploadImage(File file) async {
    try {
      final resizeResult = await compute(_resize, ImageResizeParameter(file));
      const path = '/api/common/upload-url';
      final ret = await _conn.get(path, {
        'fileName':
            'client_app/w:${resizeResult.width};h:${resizeResult.height}'
      });
      if (ret.isLeft()) {
        return ret.fold(
            (l) => left(l),
            (r) => left(const Failure.uploadFileFail(
                '파일 업로드 도중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.')));
      }
      final json = ret.getOrElse(() => "") as JsonMap;
      final url = json['url'] as String;
      final headers = <String, String>{
        HttpHeaders.contentTypeHeader: resizeResult.contentType,
      };
      await http.put(
        Uri.parse(url),
        headers: headers,
        body: resizeResult.bytes,
      );
      return right(url.split('?')[0]);
    } catch (e) {
      return left(const Failure.uploadFileFail(
          '파일 업로드 도중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
