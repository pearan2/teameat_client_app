import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.networkError(String desc) = _NetworkError;
  const factory Failure.requestFail(String desc) = _RequestFail;
  const factory Failure.invalidValueProvide(String desc) = _InvalidValueProvide;
  const factory Failure.jsonConvertFail(String desc) = _JsonConvertFail;
  const factory Failure.fetchCodeFail(String desc) = _FetchCodeFail;
  const factory Failure.fetchStoreFail(String desc) = _FetchStoreFail;
  const factory Failure.fetchStoreItemFail(String desc) = _FetchStoreItemFail;
  const factory Failure.fetchSocialLoginUrlFail(String desc) =
      _FetchSocialLoginFail;
  const factory Failure.registerOrderFail(String desc) = _RegisterOrderFail;
}
