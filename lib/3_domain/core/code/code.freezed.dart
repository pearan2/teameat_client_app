// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CodeInner _$CodeInnerFromJson(Map<String, dynamic> json) {
  return _CodeInner.fromJson(json);
}

/// @nodoc
mixin _$CodeInner {
  String get code => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CodeInnerCopyWith<CodeInner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeInnerCopyWith<$Res> {
  factory $CodeInnerCopyWith(CodeInner value, $Res Function(CodeInner) then) =
      _$CodeInnerCopyWithImpl<$Res, CodeInner>;
  @useResult
  $Res call({String code, String title});
}

/// @nodoc
class _$CodeInnerCopyWithImpl<$Res, $Val extends CodeInner>
    implements $CodeInnerCopyWith<$Res> {
  _$CodeInnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CodeInnerImplCopyWith<$Res>
    implements $CodeInnerCopyWith<$Res> {
  factory _$$CodeInnerImplCopyWith(
          _$CodeInnerImpl value, $Res Function(_$CodeInnerImpl) then) =
      __$$CodeInnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String title});
}

/// @nodoc
class __$$CodeInnerImplCopyWithImpl<$Res>
    extends _$CodeInnerCopyWithImpl<$Res, _$CodeInnerImpl>
    implements _$$CodeInnerImplCopyWith<$Res> {
  __$$CodeInnerImplCopyWithImpl(
      _$CodeInnerImpl _value, $Res Function(_$CodeInnerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? title = null,
  }) {
    return _then(_$CodeInnerImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CodeInnerImpl implements _CodeInner {
  const _$CodeInnerImpl({required this.code, required this.title});

  factory _$CodeInnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CodeInnerImplFromJson(json);

  @override
  final String code;
  @override
  final String title;

  @override
  String toString() {
    return 'CodeInner(code: $code, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeInnerImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeInnerImplCopyWith<_$CodeInnerImpl> get copyWith =>
      __$$CodeInnerImplCopyWithImpl<_$CodeInnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CodeInnerImplToJson(
      this,
    );
  }
}

abstract class _CodeInner implements CodeInner {
  const factory _CodeInner(
      {required final String code,
      required final String title}) = _$CodeInnerImpl;

  factory _CodeInner.fromJson(Map<String, dynamic> json) =
      _$CodeInnerImpl.fromJson;

  @override
  String get code;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$CodeInnerImplCopyWith<_$CodeInnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Code _$CodeFromJson(Map<String, dynamic> json) {
  return _Code.fromJson(json);
}

/// @nodoc
mixin _$Code {
  String get code => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<CodeInner>? get children => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CodeCopyWith<Code> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeCopyWith<$Res> {
  factory $CodeCopyWith(Code value, $Res Function(Code) then) =
      _$CodeCopyWithImpl<$Res, Code>;
  @useResult
  $Res call({String code, String title, List<CodeInner>? children});
}

/// @nodoc
class _$CodeCopyWithImpl<$Res, $Val extends Code>
    implements $CodeCopyWith<$Res> {
  _$CodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? title = null,
    Object? children = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CodeInner>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CodeImplCopyWith<$Res> implements $CodeCopyWith<$Res> {
  factory _$$CodeImplCopyWith(
          _$CodeImpl value, $Res Function(_$CodeImpl) then) =
      __$$CodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String title, List<CodeInner>? children});
}

/// @nodoc
class __$$CodeImplCopyWithImpl<$Res>
    extends _$CodeCopyWithImpl<$Res, _$CodeImpl>
    implements _$$CodeImplCopyWith<$Res> {
  __$$CodeImplCopyWithImpl(_$CodeImpl _value, $Res Function(_$CodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? title = null,
    Object? children = freezed,
  }) {
    return _then(_$CodeImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      children: freezed == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CodeInner>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CodeImpl implements _Code {
  const _$CodeImpl(
      {required this.code,
      required this.title,
      final List<CodeInner>? children})
      : _children = children;

  factory _$CodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CodeImplFromJson(json);

  @override
  final String code;
  @override
  final String title;
  final List<CodeInner>? _children;
  @override
  List<CodeInner>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Code(code: $code, title: $title, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, title, const DeepCollectionEquality().hash(_children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeImplCopyWith<_$CodeImpl> get copyWith =>
      __$$CodeImplCopyWithImpl<_$CodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CodeImplToJson(
      this,
    );
  }
}

abstract class _Code implements Code {
  const factory _Code(
      {required final String code,
      required final String title,
      final List<CodeInner>? children}) = _$CodeImpl;

  factory _Code.fromJson(Map<String, dynamic> json) = _$CodeImpl.fromJson;

  @override
  String get code;
  @override
  String get title;
  @override
  List<CodeInner>? get children;
  @override
  @JsonKey(ignore: true)
  _$$CodeImplCopyWith<_$CodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CodeKey {
  String get key => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CodeKeyCopyWith<CodeKey> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeKeyCopyWith<$Res> {
  factory $CodeKeyCopyWith(CodeKey value, $Res Function(CodeKey) then) =
      _$CodeKeyCopyWithImpl<$Res, CodeKey>;
  @useResult
  $Res call({String key});
}

/// @nodoc
class _$CodeKeyCopyWithImpl<$Res, $Val extends CodeKey>
    implements $CodeKeyCopyWith<$Res> {
  _$CodeKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CodeKeyImplCopyWith<$Res> implements $CodeKeyCopyWith<$Res> {
  factory _$$CodeKeyImplCopyWith(
          _$CodeKeyImpl value, $Res Function(_$CodeKeyImpl) then) =
      __$$CodeKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key});
}

/// @nodoc
class __$$CodeKeyImplCopyWithImpl<$Res>
    extends _$CodeKeyCopyWithImpl<$Res, _$CodeKeyImpl>
    implements _$$CodeKeyImplCopyWith<$Res> {
  __$$CodeKeyImplCopyWithImpl(
      _$CodeKeyImpl _value, $Res Function(_$CodeKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_$CodeKeyImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CodeKeyImpl implements _CodeKey {
  const _$CodeKeyImpl({required this.key});

  @override
  final String key;

  @override
  String toString() {
    return 'CodeKey(key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeKeyImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeKeyImplCopyWith<_$CodeKeyImpl> get copyWith =>
      __$$CodeKeyImplCopyWithImpl<_$CodeKeyImpl>(this, _$identity);
}

abstract class _CodeKey implements CodeKey {
  const factory _CodeKey({required final String key}) = _$CodeKeyImpl;

  @override
  String get key;
  @override
  @JsonKey(ignore: true)
  _$$CodeKeyImplCopyWith<_$CodeKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
