import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/error_response.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:http/http.dart' as http;

class HttpClient extends IConnection<String, Failure> {
  static const _authTokenKey = 'authTokenKey';

  final String endPoint;
  final int connectionTimeout = 5;
  final _pref = Get.find<SharedPreferences>();

  bool _isLogined = false;

  final _headers = <String, String>{
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  String? _getAuthTokenFromPref() {
    return _pref.getString(_authTokenKey);
  }

  HttpClient({required this.endPoint}) {
    final registeredToken = _getAuthTokenFromPref();
    if (registeredToken != null) {
      setAuthentication(registeredToken);
    }
  }
  @override
  bool get isLogined => _isLogined;

  @override
  void removeAuthentication() {
    _headers.remove(HttpHeaders.authorizationHeader);
    _pref.remove(_authTokenKey); // delete
    _isLogined = false;
  }

  @override
  void setAuthentication(String token) {
    final entry = <String, String>{
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    _headers.addEntries(entry.entries);
    _pref.setString(_authTokenKey, token); // setToken
    _isLogined = true;
  }

  Object _convert(String jsonString) {
    try {
      final ret = jsonDecode(jsonString);
      return ret;
    } catch (_) {
      throw Failure.jsonConvertFail("json 변환에 실패하였습니다.\n$jsonString");
    }
  }

  @override
  Future<Either<Failure, Object>> get(String path, JsonMap? params) async {
    final uri = Uri.https(endPoint, path, params);
    try {
      final res = await http
          .get(uri, headers: _headers)
          .timeout(Duration(seconds: connectionTimeout));
      final ret = _convert(utf8.decode(res.bodyBytes));
      if (res.statusCode != HttpStatus.ok) {
        final errorResponse = ErrorResponse.fromJson(ret as JsonMap);
        return left(Failure.networkError(errorResponse.message));
      }
      return right(ret);
    } catch (e) {
      return left(
          const Failure.networkError("서버와 통신에 실패 하였습니다. 잠시 후 다시 시도해주세요."));
    }
  }

  @override
  Future<Either<Failure, Object>> put(String path, JsonMap params) async {
    final uri = Uri.https(endPoint, path);
    try {
      final res = await http
          .put(uri, headers: _headers, body: jsonEncode(params))
          .timeout(Duration(seconds: connectionTimeout));
      final ret = _convert(res.body);
      if (res.statusCode != HttpStatus.ok) {
        final errorResponse = ErrorResponse.fromJson(ret as JsonMap);
        return left(Failure.networkError(errorResponse.message));
      }
      return right(ret);
    } catch (e) {
      return left(
          const Failure.networkError("서버와 통신에 실패 하였습니다. 잠시 후 다시 시도해주세요."));
    }
  }

  @override
  Future<Either<Failure, Object>> post(String path, JsonMap params) async {
    final uri = Uri.https(endPoint, path);
    try {
      final res = await http
          .post(uri, headers: _headers, body: jsonEncode(params))
          .timeout(Duration(seconds: connectionTimeout));
      final ret = _convert(res.body);
      if (res.statusCode != HttpStatus.ok) {
        final errorResponse = ErrorResponse.fromJson(ret as JsonMap);
        return left(Failure.networkError(errorResponse.message));
      }
      return right(ret);
    } catch (e) {
      return left(
          const Failure.networkError("서버와 통신에 실패 하였습니다. 잠시 후 다시 시도해주세요."));
    }
  }
}
