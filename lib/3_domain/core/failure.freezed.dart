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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String desc)? networkError,
    TResult? Function(String desc)? requestFail,
    TResult? Function(String desc)? invalidValueProvide,
    TResult? Function(String desc)? jsonConvertFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String desc)? networkError,
    TResult Function(String desc)? requestFail,
    TResult Function(String desc)? invalidValueProvide,
    TResult Function(String desc)? jsonConvertFail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkError value) networkError,
    required TResult Function(_RequestFail value) requestFail,
    required TResult Function(_InvalidValueProvide value) invalidValueProvide,
    required TResult Function(_JsonConvertFail value) jsonConvertFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkError value)? networkError,
    TResult? Function(_RequestFail value)? requestFail,
    TResult? Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult? Function(_JsonConvertFail value)? jsonConvertFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkError value)? networkError,
    TResult Function(_RequestFail value)? requestFail,
    TResult Function(_InvalidValueProvide value)? invalidValueProvide,
    TResult Function(_JsonConvertFail value)? jsonConvertFail,
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
