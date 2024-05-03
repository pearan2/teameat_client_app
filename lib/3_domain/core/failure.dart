import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.networkError(String desc) = _NetworkError;
  const factory Failure.requestFail(String desc) = _RequestFail;
  const factory Failure.invalidValueProvide(String desc) = _InvalidValueProvide;
  const factory Failure.jsonConvertFail(String desc) = _JsonConvertFail;
}
