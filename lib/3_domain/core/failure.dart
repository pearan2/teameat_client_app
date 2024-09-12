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
  const factory Failure.fetchGroupBuyingFail(String desc) =
      _FetchGroupBuyingFail;
  const factory Failure.fetchVoucherFail(String desc) = _FetchVoucherFail;
  const factory Failure.useVoucherFail(String desc) = _UseVoucherFail;
  const factory Failure.fetchMeFail(String desc) = _FetchMeFail;
  const factory Failure.fetchFollowerFail(String desc) = _FetchFollowerFail;
  const factory Failure.fetchUerSummaryFail(String desc) =
      _FetchUserSummaryFail;

  const factory Failure.updateMeFail(String desc) = _UpdateMeFail;
  const factory Failure.deleteMeFail(String desc) = _DeleteMeFail;
  const factory Failure.fetchLikeFail(String desc) = _FetchLikeFail;
  const factory Failure.uploadFileFail(String desc) = _UploadFileFail;
  const factory Failure.createGiftFail(String desc) = _CreateGiftFail;
  const factory Failure.fetchGiftFail(String desc) = _FetchGiftFail;
  const factory Failure.fetchLocalFail(String desc) = _FetchLocalFail;
  const factory Failure.fetchCurationFail(String desc) = _FetchCurationFail;
  const factory Failure.updateCurationFail(String desc) = _UpdateCurationFail;
  const factory Failure.deleteCurationFail(String desc) = _DeleteCurationFail;
  const factory Failure.registerCurationFail(String desc) =
      _RegisterCurationFail;
  const factory Failure.blockFail(String desc) = _BlockFail;
  const factory Failure.reportFail(String desc) = _ReportFail;
  const factory Failure.paymentCheckPaidFail(String desc) =
      _PaymentCheckPaidFail;
}
