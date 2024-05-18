// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchVoucherSimpleList _$SearchVoucherSimpleListFromJson(
    Map<String, dynamic> json) {
  return _SearchVoucherSimpleList.fromJson(json);
}

/// @nodoc
mixin _$SearchVoucherSimpleList {
  Code get status => throw _privateConstructorUsedError;
  Code get orderBy => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchVoucherSimpleListCopyWith<SearchVoucherSimpleList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchVoucherSimpleListCopyWith<$Res> {
  factory $SearchVoucherSimpleListCopyWith(SearchVoucherSimpleList value,
          $Res Function(SearchVoucherSimpleList) then) =
      _$SearchVoucherSimpleListCopyWithImpl<$Res, SearchVoucherSimpleList>;
  @useResult
  $Res call({Code status, Code orderBy, int pageNumber});

  $CodeCopyWith<$Res> get status;
  $CodeCopyWith<$Res> get orderBy;
}

/// @nodoc
class _$SearchVoucherSimpleListCopyWithImpl<$Res,
        $Val extends SearchVoucherSimpleList>
    implements $SearchVoucherSimpleListCopyWith<$Res> {
  _$SearchVoucherSimpleListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? orderBy = null,
    Object? pageNumber = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Code,
      orderBy: null == orderBy
          ? _value.orderBy
          : orderBy // ignore: cast_nullable_to_non_nullable
              as Code,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CodeCopyWith<$Res> get status {
    return $CodeCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CodeCopyWith<$Res> get orderBy {
    return $CodeCopyWith<$Res>(_value.orderBy, (value) {
      return _then(_value.copyWith(orderBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SearchVoucherSimpleListImplCopyWith<$Res>
    implements $SearchVoucherSimpleListCopyWith<$Res> {
  factory _$$SearchVoucherSimpleListImplCopyWith(
          _$SearchVoucherSimpleListImpl value,
          $Res Function(_$SearchVoucherSimpleListImpl) then) =
      __$$SearchVoucherSimpleListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Code status, Code orderBy, int pageNumber});

  @override
  $CodeCopyWith<$Res> get status;
  @override
  $CodeCopyWith<$Res> get orderBy;
}

/// @nodoc
class __$$SearchVoucherSimpleListImplCopyWithImpl<$Res>
    extends _$SearchVoucherSimpleListCopyWithImpl<$Res,
        _$SearchVoucherSimpleListImpl>
    implements _$$SearchVoucherSimpleListImplCopyWith<$Res> {
  __$$SearchVoucherSimpleListImplCopyWithImpl(
      _$SearchVoucherSimpleListImpl _value,
      $Res Function(_$SearchVoucherSimpleListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? orderBy = null,
    Object? pageNumber = null,
  }) {
    return _then(_$SearchVoucherSimpleListImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Code,
      orderBy: null == orderBy
          ? _value.orderBy
          : orderBy // ignore: cast_nullable_to_non_nullable
              as Code,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchVoucherSimpleListImpl implements _SearchVoucherSimpleList {
  const _$SearchVoucherSimpleListImpl(
      {required this.status, required this.orderBy, required this.pageNumber});

  factory _$SearchVoucherSimpleListImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchVoucherSimpleListImplFromJson(json);

  @override
  final Code status;
  @override
  final Code orderBy;
  @override
  final int pageNumber;

  @override
  String toString() {
    return 'SearchVoucherSimpleList(status: $status, orderBy: $orderBy, pageNumber: $pageNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchVoucherSimpleListImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.orderBy, orderBy) || other.orderBy == orderBy) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, orderBy, pageNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchVoucherSimpleListImplCopyWith<_$SearchVoucherSimpleListImpl>
      get copyWith => __$$SearchVoucherSimpleListImplCopyWithImpl<
          _$SearchVoucherSimpleListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchVoucherSimpleListImplToJson(
      this,
    );
  }
}

abstract class _SearchVoucherSimpleList implements SearchVoucherSimpleList {
  const factory _SearchVoucherSimpleList(
      {required final Code status,
      required final Code orderBy,
      required final int pageNumber}) = _$SearchVoucherSimpleListImpl;

  factory _SearchVoucherSimpleList.fromJson(Map<String, dynamic> json) =
      _$SearchVoucherSimpleListImpl.fromJson;

  @override
  Code get status;
  @override
  Code get orderBy;
  @override
  int get pageNumber;
  @override
  @JsonKey(ignore: true)
  _$$SearchVoucherSimpleListImplCopyWith<_$SearchVoucherSimpleListImpl>
      get copyWith => throw _privateConstructorUsedError;
}

VoucherSimple _$VoucherSimpleFromJson(Map<String, dynamic> json) {
  return _VoucherSimple.fromJson(json);
}

/// @nodoc
mixin _$VoucherSimple {
  int get id => throw _privateConstructorUsedError;
  DateTime get willBeExpiredAt => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  Point get storeLocation => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  String get itemName => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherSimpleCopyWith<VoucherSimple> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherSimpleCopyWith<$Res> {
  factory $VoucherSimpleCopyWith(
          VoucherSimple value, $Res Function(VoucherSimple) then) =
      _$VoucherSimpleCopyWithImpl<$Res, VoucherSimple>;
  @useResult
  $Res call(
      {int id,
      DateTime willBeExpiredAt,
      String imageUrl,
      Point storeLocation,
      String storeName,
      String itemName,
      int quantity});

  $PointCopyWith<$Res> get storeLocation;
}

/// @nodoc
class _$VoucherSimpleCopyWithImpl<$Res, $Val extends VoucherSimple>
    implements $VoucherSimpleCopyWith<$Res> {
  _$VoucherSimpleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? willBeExpiredAt = null,
    Object? imageUrl = null,
    Object? storeLocation = null,
    Object? storeName = null,
    Object? itemName = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      willBeExpiredAt: null == willBeExpiredAt
          ? _value.willBeExpiredAt
          : willBeExpiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      storeLocation: null == storeLocation
          ? _value.storeLocation
          : storeLocation // ignore: cast_nullable_to_non_nullable
              as Point,
      storeName: null == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PointCopyWith<$Res> get storeLocation {
    return $PointCopyWith<$Res>(_value.storeLocation, (value) {
      return _then(_value.copyWith(storeLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VoucherSimpleImplCopyWith<$Res>
    implements $VoucherSimpleCopyWith<$Res> {
  factory _$$VoucherSimpleImplCopyWith(
          _$VoucherSimpleImpl value, $Res Function(_$VoucherSimpleImpl) then) =
      __$$VoucherSimpleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime willBeExpiredAt,
      String imageUrl,
      Point storeLocation,
      String storeName,
      String itemName,
      int quantity});

  @override
  $PointCopyWith<$Res> get storeLocation;
}

/// @nodoc
class __$$VoucherSimpleImplCopyWithImpl<$Res>
    extends _$VoucherSimpleCopyWithImpl<$Res, _$VoucherSimpleImpl>
    implements _$$VoucherSimpleImplCopyWith<$Res> {
  __$$VoucherSimpleImplCopyWithImpl(
      _$VoucherSimpleImpl _value, $Res Function(_$VoucherSimpleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? willBeExpiredAt = null,
    Object? imageUrl = null,
    Object? storeLocation = null,
    Object? storeName = null,
    Object? itemName = null,
    Object? quantity = null,
  }) {
    return _then(_$VoucherSimpleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      willBeExpiredAt: null == willBeExpiredAt
          ? _value.willBeExpiredAt
          : willBeExpiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      storeLocation: null == storeLocation
          ? _value.storeLocation
          : storeLocation // ignore: cast_nullable_to_non_nullable
              as Point,
      storeName: null == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherSimpleImpl implements _VoucherSimple {
  const _$VoucherSimpleImpl(
      {required this.id,
      required this.willBeExpiredAt,
      required this.imageUrl,
      required this.storeLocation,
      required this.storeName,
      required this.itemName,
      required this.quantity});

  factory _$VoucherSimpleImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherSimpleImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime willBeExpiredAt;
  @override
  final String imageUrl;
  @override
  final Point storeLocation;
  @override
  final String storeName;
  @override
  final String itemName;
  @override
  final int quantity;

  @override
  String toString() {
    return 'VoucherSimple(id: $id, willBeExpiredAt: $willBeExpiredAt, imageUrl: $imageUrl, storeLocation: $storeLocation, storeName: $storeName, itemName: $itemName, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherSimpleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.willBeExpiredAt, willBeExpiredAt) ||
                other.willBeExpiredAt == willBeExpiredAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.storeLocation, storeLocation) ||
                other.storeLocation == storeLocation) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, willBeExpiredAt, imageUrl,
      storeLocation, storeName, itemName, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherSimpleImplCopyWith<_$VoucherSimpleImpl> get copyWith =>
      __$$VoucherSimpleImplCopyWithImpl<_$VoucherSimpleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherSimpleImplToJson(
      this,
    );
  }
}

abstract class _VoucherSimple implements VoucherSimple {
  const factory _VoucherSimple(
      {required final int id,
      required final DateTime willBeExpiredAt,
      required final String imageUrl,
      required final Point storeLocation,
      required final String storeName,
      required final String itemName,
      required final int quantity}) = _$VoucherSimpleImpl;

  factory _VoucherSimple.fromJson(Map<String, dynamic> json) =
      _$VoucherSimpleImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get willBeExpiredAt;
  @override
  String get imageUrl;
  @override
  Point get storeLocation;
  @override
  String get storeName;
  @override
  String get itemName;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$VoucherSimpleImplCopyWith<_$VoucherSimpleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VoucherUseLog _$VoucherUseLogFromJson(Map<String, dynamic> json) {
  return _VoucherUseLog.fromJson(json);
}

/// @nodoc
mixin _$VoucherUseLog {
  String get reason => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  DateTime get usedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherUseLogCopyWith<VoucherUseLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherUseLogCopyWith<$Res> {
  factory $VoucherUseLogCopyWith(
          VoucherUseLog value, $Res Function(VoucherUseLog) then) =
      _$VoucherUseLogCopyWithImpl<$Res, VoucherUseLog>;
  @useResult
  $Res call({String reason, int quantity, DateTime usedAt});
}

/// @nodoc
class _$VoucherUseLogCopyWithImpl<$Res, $Val extends VoucherUseLog>
    implements $VoucherUseLogCopyWith<$Res> {
  _$VoucherUseLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
    Object? quantity = null,
    Object? usedAt = null,
  }) {
    return _then(_value.copyWith(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      usedAt: null == usedAt
          ? _value.usedAt
          : usedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherUseLogImplCopyWith<$Res>
    implements $VoucherUseLogCopyWith<$Res> {
  factory _$$VoucherUseLogImplCopyWith(
          _$VoucherUseLogImpl value, $Res Function(_$VoucherUseLogImpl) then) =
      __$$VoucherUseLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reason, int quantity, DateTime usedAt});
}

/// @nodoc
class __$$VoucherUseLogImplCopyWithImpl<$Res>
    extends _$VoucherUseLogCopyWithImpl<$Res, _$VoucherUseLogImpl>
    implements _$$VoucherUseLogImplCopyWith<$Res> {
  __$$VoucherUseLogImplCopyWithImpl(
      _$VoucherUseLogImpl _value, $Res Function(_$VoucherUseLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
    Object? quantity = null,
    Object? usedAt = null,
  }) {
    return _then(_$VoucherUseLogImpl(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      usedAt: null == usedAt
          ? _value.usedAt
          : usedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherUseLogImpl implements _VoucherUseLog {
  const _$VoucherUseLogImpl(
      {required this.reason, required this.quantity, required this.usedAt});

  factory _$VoucherUseLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherUseLogImplFromJson(json);

  @override
  final String reason;
  @override
  final int quantity;
  @override
  final DateTime usedAt;

  @override
  String toString() {
    return 'VoucherUseLog(reason: $reason, quantity: $quantity, usedAt: $usedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherUseLogImpl &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.usedAt, usedAt) || other.usedAt == usedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, reason, quantity, usedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherUseLogImplCopyWith<_$VoucherUseLogImpl> get copyWith =>
      __$$VoucherUseLogImplCopyWithImpl<_$VoucherUseLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherUseLogImplToJson(
      this,
    );
  }
}

abstract class _VoucherUseLog implements VoucherUseLog {
  const factory _VoucherUseLog(
      {required final String reason,
      required final int quantity,
      required final DateTime usedAt}) = _$VoucherUseLogImpl;

  factory _VoucherUseLog.fromJson(Map<String, dynamic> json) =
      _$VoucherUseLogImpl.fromJson;

  @override
  String get reason;
  @override
  int get quantity;
  @override
  DateTime get usedAt;
  @override
  @JsonKey(ignore: true)
  _$$VoucherUseLogImplCopyWith<_$VoucherUseLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VoucherDetail _$VoucherDetailFromJson(Map<String, dynamic> json) {
  return _VoucherDetail.fromJson(json);
}

/// @nodoc
mixin _$VoucherDetail {
  int get id => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  DateTime get willBeExpiredAt => throw _privateConstructorUsedError;
  int get storeId => throw _privateConstructorUsedError;
  String get storeProfileImageUrl => throw _privateConstructorUsedError;
  String get storeName => throw _privateConstructorUsedError;
  String get storeOneLineIntroduce => throw _privateConstructorUsedError;
  String get storeAddress => throw _privateConstructorUsedError;
  String get storeOperationTime => throw _privateConstructorUsedError;
  String get itemName => throw _privateConstructorUsedError;
  List<String> get itemImageUrls => throw _privateConstructorUsedError;
  List<VoucherUseLog> get useLogs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherDetailCopyWith<VoucherDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherDetailCopyWith<$Res> {
  factory $VoucherDetailCopyWith(
          VoucherDetail value, $Res Function(VoucherDetail) then) =
      _$VoucherDetailCopyWithImpl<$Res, VoucherDetail>;
  @useResult
  $Res call(
      {int id,
      int quantity,
      DateTime willBeExpiredAt,
      int storeId,
      String storeProfileImageUrl,
      String storeName,
      String storeOneLineIntroduce,
      String storeAddress,
      String storeOperationTime,
      String itemName,
      List<String> itemImageUrls,
      List<VoucherUseLog> useLogs});
}

/// @nodoc
class _$VoucherDetailCopyWithImpl<$Res, $Val extends VoucherDetail>
    implements $VoucherDetailCopyWith<$Res> {
  _$VoucherDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quantity = null,
    Object? willBeExpiredAt = null,
    Object? storeId = null,
    Object? storeProfileImageUrl = null,
    Object? storeName = null,
    Object? storeOneLineIntroduce = null,
    Object? storeAddress = null,
    Object? storeOperationTime = null,
    Object? itemName = null,
    Object? itemImageUrls = null,
    Object? useLogs = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      willBeExpiredAt: null == willBeExpiredAt
          ? _value.willBeExpiredAt
          : willBeExpiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      storeProfileImageUrl: null == storeProfileImageUrl
          ? _value.storeProfileImageUrl
          : storeProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      storeName: null == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      storeOneLineIntroduce: null == storeOneLineIntroduce
          ? _value.storeOneLineIntroduce
          : storeOneLineIntroduce // ignore: cast_nullable_to_non_nullable
              as String,
      storeAddress: null == storeAddress
          ? _value.storeAddress
          : storeAddress // ignore: cast_nullable_to_non_nullable
              as String,
      storeOperationTime: null == storeOperationTime
          ? _value.storeOperationTime
          : storeOperationTime // ignore: cast_nullable_to_non_nullable
              as String,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      itemImageUrls: null == itemImageUrls
          ? _value.itemImageUrls
          : itemImageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      useLogs: null == useLogs
          ? _value.useLogs
          : useLogs // ignore: cast_nullable_to_non_nullable
              as List<VoucherUseLog>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherDetailImplCopyWith<$Res>
    implements $VoucherDetailCopyWith<$Res> {
  factory _$$VoucherDetailImplCopyWith(
          _$VoucherDetailImpl value, $Res Function(_$VoucherDetailImpl) then) =
      __$$VoucherDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int quantity,
      DateTime willBeExpiredAt,
      int storeId,
      String storeProfileImageUrl,
      String storeName,
      String storeOneLineIntroduce,
      String storeAddress,
      String storeOperationTime,
      String itemName,
      List<String> itemImageUrls,
      List<VoucherUseLog> useLogs});
}

/// @nodoc
class __$$VoucherDetailImplCopyWithImpl<$Res>
    extends _$VoucherDetailCopyWithImpl<$Res, _$VoucherDetailImpl>
    implements _$$VoucherDetailImplCopyWith<$Res> {
  __$$VoucherDetailImplCopyWithImpl(
      _$VoucherDetailImpl _value, $Res Function(_$VoucherDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quantity = null,
    Object? willBeExpiredAt = null,
    Object? storeId = null,
    Object? storeProfileImageUrl = null,
    Object? storeName = null,
    Object? storeOneLineIntroduce = null,
    Object? storeAddress = null,
    Object? storeOperationTime = null,
    Object? itemName = null,
    Object? itemImageUrls = null,
    Object? useLogs = null,
  }) {
    return _then(_$VoucherDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      willBeExpiredAt: null == willBeExpiredAt
          ? _value.willBeExpiredAt
          : willBeExpiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int,
      storeProfileImageUrl: null == storeProfileImageUrl
          ? _value.storeProfileImageUrl
          : storeProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      storeName: null == storeName
          ? _value.storeName
          : storeName // ignore: cast_nullable_to_non_nullable
              as String,
      storeOneLineIntroduce: null == storeOneLineIntroduce
          ? _value.storeOneLineIntroduce
          : storeOneLineIntroduce // ignore: cast_nullable_to_non_nullable
              as String,
      storeAddress: null == storeAddress
          ? _value.storeAddress
          : storeAddress // ignore: cast_nullable_to_non_nullable
              as String,
      storeOperationTime: null == storeOperationTime
          ? _value.storeOperationTime
          : storeOperationTime // ignore: cast_nullable_to_non_nullable
              as String,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      itemImageUrls: null == itemImageUrls
          ? _value._itemImageUrls
          : itemImageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      useLogs: null == useLogs
          ? _value._useLogs
          : useLogs // ignore: cast_nullable_to_non_nullable
              as List<VoucherUseLog>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherDetailImpl implements _VoucherDetail {
  const _$VoucherDetailImpl(
      {required this.id,
      required this.quantity,
      required this.willBeExpiredAt,
      required this.storeId,
      required this.storeProfileImageUrl,
      required this.storeName,
      required this.storeOneLineIntroduce,
      required this.storeAddress,
      required this.storeOperationTime,
      required this.itemName,
      required final List<String> itemImageUrls,
      required final List<VoucherUseLog> useLogs})
      : _itemImageUrls = itemImageUrls,
        _useLogs = useLogs;

  factory _$VoucherDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherDetailImplFromJson(json);

  @override
  final int id;
  @override
  final int quantity;
  @override
  final DateTime willBeExpiredAt;
  @override
  final int storeId;
  @override
  final String storeProfileImageUrl;
  @override
  final String storeName;
  @override
  final String storeOneLineIntroduce;
  @override
  final String storeAddress;
  @override
  final String storeOperationTime;
  @override
  final String itemName;
  final List<String> _itemImageUrls;
  @override
  List<String> get itemImageUrls {
    if (_itemImageUrls is EqualUnmodifiableListView) return _itemImageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemImageUrls);
  }

  final List<VoucherUseLog> _useLogs;
  @override
  List<VoucherUseLog> get useLogs {
    if (_useLogs is EqualUnmodifiableListView) return _useLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_useLogs);
  }

  @override
  String toString() {
    return 'VoucherDetail(id: $id, quantity: $quantity, willBeExpiredAt: $willBeExpiredAt, storeId: $storeId, storeProfileImageUrl: $storeProfileImageUrl, storeName: $storeName, storeOneLineIntroduce: $storeOneLineIntroduce, storeAddress: $storeAddress, storeOperationTime: $storeOperationTime, itemName: $itemName, itemImageUrls: $itemImageUrls, useLogs: $useLogs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.willBeExpiredAt, willBeExpiredAt) ||
                other.willBeExpiredAt == willBeExpiredAt) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeProfileImageUrl, storeProfileImageUrl) ||
                other.storeProfileImageUrl == storeProfileImageUrl) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.storeOneLineIntroduce, storeOneLineIntroduce) ||
                other.storeOneLineIntroduce == storeOneLineIntroduce) &&
            (identical(other.storeAddress, storeAddress) ||
                other.storeAddress == storeAddress) &&
            (identical(other.storeOperationTime, storeOperationTime) ||
                other.storeOperationTime == storeOperationTime) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            const DeepCollectionEquality()
                .equals(other._itemImageUrls, _itemImageUrls) &&
            const DeepCollectionEquality().equals(other._useLogs, _useLogs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      quantity,
      willBeExpiredAt,
      storeId,
      storeProfileImageUrl,
      storeName,
      storeOneLineIntroduce,
      storeAddress,
      storeOperationTime,
      itemName,
      const DeepCollectionEquality().hash(_itemImageUrls),
      const DeepCollectionEquality().hash(_useLogs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherDetailImplCopyWith<_$VoucherDetailImpl> get copyWith =>
      __$$VoucherDetailImplCopyWithImpl<_$VoucherDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherDetailImplToJson(
      this,
    );
  }
}

abstract class _VoucherDetail implements VoucherDetail {
  const factory _VoucherDetail(
      {required final int id,
      required final int quantity,
      required final DateTime willBeExpiredAt,
      required final int storeId,
      required final String storeProfileImageUrl,
      required final String storeName,
      required final String storeOneLineIntroduce,
      required final String storeAddress,
      required final String storeOperationTime,
      required final String itemName,
      required final List<String> itemImageUrls,
      required final List<VoucherUseLog> useLogs}) = _$VoucherDetailImpl;

  factory _VoucherDetail.fromJson(Map<String, dynamic> json) =
      _$VoucherDetailImpl.fromJson;

  @override
  int get id;
  @override
  int get quantity;
  @override
  DateTime get willBeExpiredAt;
  @override
  int get storeId;
  @override
  String get storeProfileImageUrl;
  @override
  String get storeName;
  @override
  String get storeOneLineIntroduce;
  @override
  String get storeAddress;
  @override
  String get storeOperationTime;
  @override
  String get itemName;
  @override
  List<String> get itemImageUrls;
  @override
  List<VoucherUseLog> get useLogs;
  @override
  @JsonKey(ignore: true)
  _$$VoucherDetailImplCopyWith<_$VoucherDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
