// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  String get desc => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String desc});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_value.copyWith(
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
          _$NetworkErrorImpl value, $Res Function(_$NetworkErrorImpl) then) =
      __$$NetworkErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
      _$NetworkErrorImpl _value, $Res Function(_$NetworkErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$NetworkErrorImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NetworkErrorImpl implements _NetworkError {
  const _$NetworkErrorImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.networkError(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkErrorImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      __$$NetworkErrorImplCopyWithImpl<_$NetworkErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return networkError(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return networkError?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class _NetworkError implements Failure {
  const factory _NetworkError(final String desc) = _$NetworkErrorImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestFailImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$RequestFailImplCopyWith(
          _$RequestFailImpl value, $Res Function(_$RequestFailImpl) then) =
      __$$RequestFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$RequestFailImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$RequestFailImpl>
    implements _$$RequestFailImplCopyWith<$Res> {
  __$$RequestFailImplCopyWithImpl(
      _$RequestFailImpl _value, $Res Function(_$RequestFailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$RequestFailImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RequestFailImpl implements _RequestFail {
  const _$RequestFailImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.requestFail(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestFailImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestFailImplCopyWith<_$RequestFailImpl> get copyWith =>
      __$$RequestFailImplCopyWithImpl<_$RequestFailImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return requestFail(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return requestFail?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (requestFail != null) {
      return requestFail(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return requestFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return requestFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (requestFail != null) {
      return requestFail(this);
    }
    return orElse();
  }
}

abstract class _RequestFail implements Failure {
  const factory _RequestFail(final String desc) = _$RequestFailImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$RequestFailImplCopyWith<_$RequestFailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidValueProvideImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$InvalidValueProvideImplCopyWith(_$InvalidValueProvideImpl value,
          $Res Function(_$InvalidValueProvideImpl) then) =
      __$$InvalidValueProvideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$InvalidValueProvideImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InvalidValueProvideImpl>
    implements _$$InvalidValueProvideImplCopyWith<$Res> {
  __$$InvalidValueProvideImplCopyWithImpl(_$InvalidValueProvideImpl _value,
      $Res Function(_$InvalidValueProvideImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$InvalidValueProvideImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvalidValueProvideImpl implements _InvalidValueProvide {
  const _$InvalidValueProvideImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.invalidValueProvide(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidValueProvideImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidValueProvideImplCopyWith<_$InvalidValueProvideImpl> get copyWith =>
      __$$InvalidValueProvideImplCopyWithImpl<_$InvalidValueProvideImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return invalidValueProvide(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return invalidValueProvide?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (invalidValueProvide != null) {
      return invalidValueProvide(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return invalidValueProvide(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return invalidValueProvide?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (invalidValueProvide != null) {
      return invalidValueProvide(this);
    }
    return orElse();
  }
}

abstract class _InvalidValueProvide implements Failure {
  const factory _InvalidValueProvide(final String desc) =
      _$InvalidValueProvideImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$InvalidValueProvideImplCopyWith<_$InvalidValueProvideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$JsonConvertFailImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$JsonConvertFailImplCopyWith(_$JsonConvertFailImpl value,
          $Res Function(_$JsonConvertFailImpl) then) =
      __$$JsonConvertFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$JsonConvertFailImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$JsonConvertFailImpl>
    implements _$$JsonConvertFailImplCopyWith<$Res> {
  __$$JsonConvertFailImplCopyWithImpl(
      _$JsonConvertFailImpl _value, $Res Function(_$JsonConvertFailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$JsonConvertFailImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$JsonConvertFailImpl implements _JsonConvertFail {
  const _$JsonConvertFailImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.jsonConvertFail(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonConvertFailImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonConvertFailImplCopyWith<_$JsonConvertFailImpl> get copyWith =>
      __$$JsonConvertFailImplCopyWithImpl<_$JsonConvertFailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return jsonConvertFail(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return jsonConvertFail?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (jsonConvertFail != null) {
      return jsonConvertFail(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return jsonConvertFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return jsonConvertFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (jsonConvertFail != null) {
      return jsonConvertFail(this);
    }
    return orElse();
  }
}

abstract class _JsonConvertFail implements Failure {
  const factory _JsonConvertFail(final String desc) = _$JsonConvertFailImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$JsonConvertFailImplCopyWith<_$JsonConvertFailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchCodeFailImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$FetchCodeFailImplCopyWith(
          _$FetchCodeFailImpl value, $Res Function(_$FetchCodeFailImpl) then) =
      __$$FetchCodeFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$FetchCodeFailImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$FetchCodeFailImpl>
    implements _$$FetchCodeFailImplCopyWith<$Res> {
  __$$FetchCodeFailImplCopyWithImpl(
      _$FetchCodeFailImpl _value, $Res Function(_$FetchCodeFailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$FetchCodeFailImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchCodeFailImpl implements _FetchCodeFail {
  const _$FetchCodeFailImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.fetchCodeFail(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchCodeFailImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchCodeFailImplCopyWith<_$FetchCodeFailImpl> get copyWith =>
      __$$FetchCodeFailImplCopyWithImpl<_$FetchCodeFailImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return fetchCodeFail(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return fetchCodeFail?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchCodeFail != null) {
      return fetchCodeFail(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return fetchCodeFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return fetchCodeFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchCodeFail != null) {
      return fetchCodeFail(this);
    }
    return orElse();
  }
}

abstract class _FetchCodeFail implements Failure {
  const factory _FetchCodeFail(final String desc) = _$FetchCodeFailImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$FetchCodeFailImplCopyWith<_$FetchCodeFailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchStoreFailImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$FetchStoreFailImplCopyWith(_$FetchStoreFailImpl value,
          $Res Function(_$FetchStoreFailImpl) then) =
      __$$FetchStoreFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$FetchStoreFailImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$FetchStoreFailImpl>
    implements _$$FetchStoreFailImplCopyWith<$Res> {
  __$$FetchStoreFailImplCopyWithImpl(
      _$FetchStoreFailImpl _value, $Res Function(_$FetchStoreFailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$FetchStoreFailImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchStoreFailImpl implements _FetchStoreFail {
  const _$FetchStoreFailImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.fetchStoreFail(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchStoreFailImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchStoreFailImplCopyWith<_$FetchStoreFailImpl> get copyWith =>
      __$$FetchStoreFailImplCopyWithImpl<_$FetchStoreFailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return fetchStoreFail(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return fetchStoreFail?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchStoreFail != null) {
      return fetchStoreFail(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return fetchStoreFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return fetchStoreFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchStoreFail != null) {
      return fetchStoreFail(this);
    }
    return orElse();
  }
}

abstract class _FetchStoreFail implements Failure {
  const factory _FetchStoreFail(final String desc) = _$FetchStoreFailImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$FetchStoreFailImplCopyWith<_$FetchStoreFailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchStoreItemFailImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$FetchStoreItemFailImplCopyWith(_$FetchStoreItemFailImpl value,
          $Res Function(_$FetchStoreItemFailImpl) then) =
      __$$FetchStoreItemFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$FetchStoreItemFailImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$FetchStoreItemFailImpl>
    implements _$$FetchStoreItemFailImplCopyWith<$Res> {
  __$$FetchStoreItemFailImplCopyWithImpl(_$FetchStoreItemFailImpl _value,
      $Res Function(_$FetchStoreItemFailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$FetchStoreItemFailImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchStoreItemFailImpl implements _FetchStoreItemFail {
  const _$FetchStoreItemFailImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.fetchStoreItemFail(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchStoreItemFailImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchStoreItemFailImplCopyWith<_$FetchStoreItemFailImpl> get copyWith =>
      __$$FetchStoreItemFailImplCopyWithImpl<_$FetchStoreItemFailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return fetchStoreItemFail(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return fetchStoreItemFail?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchStoreItemFail != null) {
      return fetchStoreItemFail(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return fetchStoreItemFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return fetchStoreItemFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchStoreItemFail != null) {
      return fetchStoreItemFail(this);
    }
    return orElse();
  }
}

abstract class _FetchStoreItemFail implements Failure {
  const factory _FetchStoreItemFail(final String desc) =
      _$FetchStoreItemFailImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$FetchStoreItemFailImplCopyWith<_$FetchStoreItemFailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchSocialLoginFailImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$FetchSocialLoginFailImplCopyWith(_$FetchSocialLoginFailImpl value,
          $Res Function(_$FetchSocialLoginFailImpl) then) =
      __$$FetchSocialLoginFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$FetchSocialLoginFailImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$FetchSocialLoginFailImpl>
    implements _$$FetchSocialLoginFailImplCopyWith<$Res> {
  __$$FetchSocialLoginFailImplCopyWithImpl(_$FetchSocialLoginFailImpl _value,
      $Res Function(_$FetchSocialLoginFailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$FetchSocialLoginFailImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchSocialLoginFailImpl implements _FetchSocialLoginFail {
  const _$FetchSocialLoginFailImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.fetchSocialLoginUrlFail(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchSocialLoginFailImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchSocialLoginFailImplCopyWith<_$FetchSocialLoginFailImpl>
      get copyWith =>
          __$$FetchSocialLoginFailImplCopyWithImpl<_$FetchSocialLoginFailImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return fetchSocialLoginUrlFail(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return fetchSocialLoginUrlFail?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchSocialLoginUrlFail != null) {
      return fetchSocialLoginUrlFail(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return fetchSocialLoginUrlFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return fetchSocialLoginUrlFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchSocialLoginUrlFail != null) {
      return fetchSocialLoginUrlFail(this);
    }
    return orElse();
  }
}

abstract class _FetchSocialLoginFail implements Failure {
  const factory _FetchSocialLoginFail(final String desc) =
      _$FetchSocialLoginFailImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$FetchSocialLoginFailImplCopyWith<_$FetchSocialLoginFailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterOrderFailImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$RegisterOrderFailImplCopyWith(_$RegisterOrderFailImpl value,
          $Res Function(_$RegisterOrderFailImpl) then) =
      __$$RegisterOrderFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$RegisterOrderFailImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$RegisterOrderFailImpl>
    implements _$$RegisterOrderFailImplCopyWith<$Res> {
  __$$RegisterOrderFailImplCopyWithImpl(_$RegisterOrderFailImpl _value,
      $Res Function(_$RegisterOrderFailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$RegisterOrderFailImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterOrderFailImpl implements _RegisterOrderFail {
  const _$RegisterOrderFailImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.registerOrderFail(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterOrderFailImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterOrderFailImplCopyWith<_$RegisterOrderFailImpl> get copyWith =>
      __$$RegisterOrderFailImplCopyWithImpl<_$RegisterOrderFailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return registerOrderFail(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return registerOrderFail?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (registerOrderFail != null) {
      return registerOrderFail(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return registerOrderFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return registerOrderFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (registerOrderFail != null) {
      return registerOrderFail(this);
    }
    return orElse();
  }
}

abstract class _RegisterOrderFail implements Failure {
  const factory _RegisterOrderFail(final String desc) = _$RegisterOrderFailImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$RegisterOrderFailImplCopyWith<_$RegisterOrderFailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchVoucherFailImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$FetchVoucherFailImplCopyWith(_$FetchVoucherFailImpl value,
          $Res Function(_$FetchVoucherFailImpl) then) =
      __$$FetchVoucherFailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc});
}

/// @nodoc
class __$$FetchVoucherFailImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$FetchVoucherFailImpl>
    implements _$$FetchVoucherFailImplCopyWith<$Res> {
  __$$FetchVoucherFailImplCopyWithImpl(_$FetchVoucherFailImpl _value,
      $Res Function(_$FetchVoucherFailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
  }) {
    return _then(_$FetchVoucherFailImpl(
      null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchVoucherFailImpl implements _FetchVoucherFail {
  const _$FetchVoucherFailImpl(this.desc);

  @override
  final String desc;

  @override
  String toString() {
    return 'Failure.fetchVoucherFail(desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchVoucherFailImpl &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @override
  int get hashCode => Object.hash(runtimeType, desc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchVoucherFailImplCopyWith<_$FetchVoucherFailImpl> get copyWith =>
      __$$FetchVoucherFailImplCopyWithImpl<_$FetchVoucherFailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String desc) networkError,
    required TResult Function(String desc) requestFail,
    required TResult Function(String desc) invalidValueProvide,
    required TResult Function(String desc) jsonConvertFail,
    required TResult Function(String desc) fetchCodeFail,
    required TResult Function(String desc) fetchStoreFail,
    required TResult Function(String desc) fetchStoreItemFail,
    required TResult Function(String desc) fetchSocialLoginUrlFail,
    required TResult Function(String desc) registerOrderFail,
    required TResult Function(String desc) fetchVoucherFail,
  }) {
    return fetchVoucherFail(desc);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
    TResult? Function(String desc)? fetchCodeFail,
    TResult? Function(String desc)? fetchStoreFail,
    TResult? Function(String desc)? fetchStoreItemFail,
    TResult? Function(String desc)? fetchSocialLoginUrlFail,
    TResult? Function(String desc)? registerOrderFail,
    TResult? Function(String desc)? fetchVoucherFail,
  }) {
    return fetchVoucherFail?.call(desc);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    TResult Function(String desc)? fetchCodeFail,
    TResult Function(String desc)? fetchStoreFail,
    TResult Function(String desc)? fetchStoreItemFail,
    TResult Function(String desc)? fetchSocialLoginUrlFail,
    TResult Function(String desc)? registerOrderFail,
    TResult Function(String desc)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchVoucherFail != null) {
      return fetchVoucherFail(desc);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
    required TResult Function(_FetchCodeFail value) fetchCodeFail,
    required TResult Function(_FetchStoreFail value) fetchStoreFail,
    required TResult Function(_FetchStoreItemFail value) fetchStoreItemFail,
    required TResult Function(_FetchSocialLoginFail value)
        fetchSocialLoginUrlFail,
    required TResult Function(_RegisterOrderFail value) registerOrderFail,
    required TResult Function(_FetchVoucherFail value) fetchVoucherFail,
  }) {
    return fetchVoucherFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
    TResult? Function(_FetchCodeFail value)? fetchCodeFail,
    TResult? Function(_FetchStoreFail value)? fetchStoreFail,
    TResult? Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult? Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult? Function(_RegisterOrderFail value)? registerOrderFail,
    TResult? Function(_FetchVoucherFail value)? fetchVoucherFail,
  }) {
    return fetchVoucherFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
    TResult Function(_FetchCodeFail value)? fetchCodeFail,
    TResult Function(_FetchStoreFail value)? fetchStoreFail,
    TResult Function(_FetchStoreItemFail value)? fetchStoreItemFail,
    TResult Function(_FetchSocialLoginFail value)? fetchSocialLoginUrlFail,
    TResult Function(_RegisterOrderFail value)? registerOrderFail,
    TResult Function(_FetchVoucherFail value)? fetchVoucherFail,
    required TResult orElse(),
  }) {
    if (fetchVoucherFail != null) {
      return fetchVoucherFail(this);
    }
    return orElse();
  }
}

abstract class _FetchVoucherFail implements Failure {
  const factory _FetchVoucherFail(final String desc) = _$FetchVoucherFailImpl;

  @override
  String get desc;
  @override
  @JsonKey(ignore: true)
  _$$FetchVoucherFailImplCopyWith<_$FetchVoucherFailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
