// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PurchaseMethod {
  String get method => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PurchaseMethodCopyWith<PurchaseMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseMethodCopyWith<$Res> {
  factory $PurchaseMethodCopyWith(
          PurchaseMethod value, $Res Function(PurchaseMethod) then) =
      _$PurchaseMethodCopyWithImpl<$Res, PurchaseMethod>;
  @useResult
  $Res call({String method});
}

/// @nodoc
class _$PurchaseMethodCopyWithImpl<$Res, $Val extends PurchaseMethod>
    implements $PurchaseMethodCopyWith<$Res> {
  _$PurchaseMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseMethodImplCopyWith<$Res>
    implements $PurchaseMethodCopyWith<$Res> {
  factory _$$PurchaseMethodImplCopyWith(_$PurchaseMethodImpl value,
          $Res Function(_$PurchaseMethodImpl) then) =
      __$$PurchaseMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String method});
}

/// @nodoc
class __$$PurchaseMethodImplCopyWithImpl<$Res>
    extends _$PurchaseMethodCopyWithImpl<$Res, _$PurchaseMethodImpl>
    implements _$$PurchaseMethodImplCopyWith<$Res> {
  __$$PurchaseMethodImplCopyWithImpl(
      _$PurchaseMethodImpl _value, $Res Function(_$PurchaseMethodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
  }) {
    return _then(_$PurchaseMethodImpl(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PurchaseMethodImpl implements _PurchaseMethod {
  const _$PurchaseMethodImpl({required this.method});

  @override
  final String method;

  @override
  String toString() {
    return 'PurchaseMethod(method: $method)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseMethodImpl &&
            (identical(other.method, method) || other.method == method));
  }

  @override
  int get hashCode => Object.hash(runtimeType, method);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseMethodImplCopyWith<_$PurchaseMethodImpl> get copyWith =>
      __$$PurchaseMethodImplCopyWithImpl<_$PurchaseMethodImpl>(
          this, _$identity);
}

abstract class _PurchaseMethod implements PurchaseMethod {
  const factory _PurchaseMethod({required final String method}) =
      _$PurchaseMethodImpl;

  @override
  String get method;
  @override
  @JsonKey(ignore: true)
  _$$PurchaseMethodImplCopyWith<_$PurchaseMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
