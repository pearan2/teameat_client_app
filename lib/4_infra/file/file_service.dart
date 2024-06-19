import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/file/i_file_service.dart';
import 'package:http/http.dart' as http;
import 'package:teameat/99_util/image.dart';

class FileService implements IFileService {
  static const imageSideMax = 1024;
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, String>> uploadImageFile(File file) async {
    final resizeResult = await resize(ImageResizeParameter(file));
    return uploadImage(resizeResult);
  }

  @override
  Future<Either<Failure, String>> uploadImage(ImageResizeResult image) async {
    try {
      const path = '/api/common/upload-url';
      final ret = await _conn.get(
          path, {'fileName': 'client_app/w:${image.width};h:${image.height}'});
      if (ret.isLeft()) {
        return ret.fold(
            (l) => left(l),
            (r) => left(const Failure.uploadFileFail(
                '파일 업로드 도중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.')));
      }
      final json = ret.getOrElse(() => "") as JsonMap;
      final url = json['url'] as String;
      final headers = <String, String>{
        HttpHeaders.contentTypeHeader: image.contentType,
      };
      await http.put(
        Uri.parse(url),
        headers: headers,
        body: image.bytes,
      );
      return right(url.split('?')[0]);
    } catch (e) {
      return left(const Failure.uploadFileFail(
          '파일 업로드 도중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
