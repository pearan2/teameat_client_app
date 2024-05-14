// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Point _$PointFromJson(Map<String, dynamic> json) {
  return _Point.fromJson(json);
}

/// @nodoc
mixin _$Point {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointCopyWith<Point> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointCopyWith<$Res> {
  factory $PointCopyWith(Point value, $Res Function(Point) then) =
      _$PointCopyWithImpl<$Res, Point>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$PointCopyWithImpl<$Res, $Val extends Point>
    implements $PointCopyWith<$Res> {
  _$PointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointImplCopyWith<$Res> implements $PointCopyWith<$Res> {
  factory _$$PointImplCopyWith(
          _$PointImpl value, $Res Function(_$PointImpl) then) =
      __$$PointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$PointImplCopyWithImpl<$Res>
    extends _$PointCopyWithImpl<$Res, _$PointImpl>
    implements _$$PointImplCopyWith<$Res> {
  __$$PointImplCopyWithImpl(
      _$PointImpl _value, $Res Function(_$PointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$PointImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointImpl implements _Point {
  const _$PointImpl({required this.latitude, required this.longitude});

  factory _$PointImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'Point(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PointImplCopyWith<_$PointImpl> get copyWith =>
      __$$PointImplCopyWithImpl<_$PointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointImplToJson(
      this,
    );
  }
}

abstract class _Point implements Point {
  const factory _Point(
      {required final double latitude,
      required final double longitude}) = _$PointImpl;

  factory _Point.fromJson(Map<String, dynamic> json) = _$PointImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$PointImplCopyWith<_$PointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchStoreSimpleList _$SearchStoreSimpleListFromJson(
    Map<String, dynamic> json) {
  return _SearchStoreSimpleList.fromJson(json);
}

/// @nodoc
mixin _$SearchStoreSimpleList {
  String? get searchText => throw _privateConstructorUsedError;
  List<String>? get hashTags => throw _privateConstructorUsedError;
  List<String>? get categories => throw _privateConstructorUsedError;
  Point? get baseLocation => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchStoreSimpleListCopyWith<SearchStoreSimpleList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStoreSimpleListCopyWith<$Res> {
  factory $SearchStoreSimpleListCopyWith(SearchStoreSimpleList value,
          $Res Function(SearchStoreSimpleList) then) =
      _$SearchStoreSimpleListCopyWithImpl<$Res, SearchStoreSimpleList>;
  @useResult
  $Res call(
      {String? searchText,
      List<String>? hashTags,
      List<String>? categories,
      Point? baseLocation,
      int pageNumber});

  $PointCopyWith<$Res>? get baseLocation;
}

/// @nodoc
class _$SearchStoreSimpleListCopyWithImpl<$Res,
        $Val extends SearchStoreSimpleList>
    implements $SearchStoreSimpleListCopyWith<$Res> {
  _$SearchStoreSimpleListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchText = freezed,
    Object? hashTags = freezed,
    Object? categories = freezed,
    Object? baseLocation = freezed,
    Object? pageNumber = null,
  }) {
    return _then(_value.copyWith(
      searchText: freezed == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
      hashTags: freezed == hashTags
          ? _value.hashTags
          : hashTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      baseLocation: freezed == baseLocation
          ? _value.baseLocation
          : baseLocation // ignore: cast_nullable_to_non_nullable
              as Point?,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PointCopyWith<$Res>? get baseLocation {
    if (_value.baseLocation == null) {
      return null;
    }

    return $PointCopyWith<$Res>(_value.baseLocation!, (value) {
      return _then(_value.copyWith(baseLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SearchStoreSimpleListImplCopyWith<$Res>
    implements $SearchStoreSimpleListCopyWith<$Res> {
  factory _$$SearchStoreSimpleListImplCopyWith(
          _$SearchStoreSimpleListImpl value,
          $Res Function(_$SearchStoreSimpleListImpl) then) =
      __$$SearchStoreSimpleListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? searchText,
      List<String>? hashTags,
      List<String>? categories,
      Point? baseLocation,
      int pageNumber});

  @override
  $PointCopyWith<$Res>? get baseLocation;
}

/// @nodoc
class __$$SearchStoreSimpleListImplCopyWithImpl<$Res>
    extends _$SearchStoreSimpleListCopyWithImpl<$Res,
        _$SearchStoreSimpleListImpl>
    implements _$$SearchStoreSimpleListImplCopyWith<$Res> {
  __$$SearchStoreSimpleListImplCopyWithImpl(_$SearchStoreSimpleListImpl _value,
      $Res Function(_$SearchStoreSimpleListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchText = freezed,
    Object? hashTags = freezed,
    Object? categories = freezed,
    Object? baseLocation = freezed,
    Object? pageNumber = null,
  }) {
    return _then(_$SearchStoreSimpleListImpl(
      searchText: freezed == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
      hashTags: freezed == hashTags
          ? _value._hashTags
          : hashTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      baseLocation: freezed == baseLocation
          ? _value.baseLocation
          : baseLocation // ignore: cast_nullable_to_non_nullable
              as Point?,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchStoreSimpleListImpl implements _SearchStoreSimpleList {
  const _$SearchStoreSimpleListImpl(
      {this.searchText,
      final List<String>? hashTags,
      final List<String>? categories,
      this.baseLocation,
      required this.pageNumber})
      : _hashTags = hashTags,
        _categories = categories;

  factory _$SearchStoreSimpleListImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchStoreSimpleListImplFromJson(json);

  @override
  final String? searchText;
  final List<String>? _hashTags;
  @override
  List<String>? get hashTags {
    final value = _hashTags;
    if (value == null) return null;
    if (_hashTags is EqualUnmodifiableListView) return _hashTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _categories;
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Point? baseLocation;
  @override
  final int pageNumber;

  @override
  String toString() {
    return 'SearchStoreSimpleList(searchText: $searchText, hashTags: $hashTags, categories: $categories, baseLocation: $baseLocation, pageNumber: $pageNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStoreSimpleListImpl &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText) &&
            const DeepCollectionEquality().equals(other._hashTags, _hashTags) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.baseLocation, baseLocation) ||
                other.baseLocation == baseLocation) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchText,
      const DeepCollectionEquality().hash(_hashTags),
      const DeepCollectionEquality().hash(_categories),
      baseLocation,
      pageNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStoreSimpleListImplCopyWith<_$SearchStoreSimpleListImpl>
      get copyWith => __$$SearchStoreSimpleListImplCopyWithImpl<
          _$SearchStoreSimpleListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchStoreSimpleListImplToJson(
      this,
    );
  }
}

abstract class _SearchStoreSimpleList implements SearchStoreSimpleList {
  const factory _SearchStoreSimpleList(
      {final String? searchText,
      final List<String>? hashTags,
      final List<String>? categories,
      final Point? baseLocation,
      required final int pageNumber}) = _$SearchStoreSimpleListImpl;

  factory _SearchStoreSimpleList.fromJson(Map<String, dynamic> json) =
      _$SearchStoreSimpleListImpl.fromJson;

  @override
  String? get searchText;
  @override
  List<String>? get hashTags;
  @override
  List<String>? get categories;
  @override
  Point? get baseLocation;
  @override
  int get pageNumber;
  @override
  @JsonKey(ignore: true)
  _$$SearchStoreSimpleListImplCopyWith<_$SearchStoreSimpleListImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StoreSimple _$StoreSimpleFromJson(Map<String, dynamic> json) {
  return _StoreSimple.fromJson(json);
}

/// @nodoc
mixin _$StoreSimple {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  Point get location => throw _privateConstructorUsedError;
  List<ItemSimple> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreSimpleCopyWith<StoreSimple> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreSimpleCopyWith<$Res> {
  factory $StoreSimpleCopyWith(
          StoreSimple value, $Res Function(StoreSimple) then) =
      _$StoreSimpleCopyWithImpl<$Res, StoreSimple>;
  @useResult
  $Res call(
      {int id,
      String name,
      String profileImageUrl,
      String address,
      Point location,
      List<ItemSimple> items});

  $PointCopyWith<$Res> get location;
}

/// @nodoc
class _$StoreSimpleCopyWithImpl<$Res, $Val extends StoreSimple>
    implements $StoreSimpleCopyWith<$Res> {
  _$StoreSimpleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profileImageUrl = null,
    Object? address = null,
    Object? location = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Point,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemSimple>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PointCopyWith<$Res> get location {
    return $PointCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreSimpleImplCopyWith<$Res>
    implements $StoreSimpleCopyWith<$Res> {
  factory _$$StoreSimpleImplCopyWith(
          _$StoreSimpleImpl value, $Res Function(_$StoreSimpleImpl) then) =
      __$$StoreSimpleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String profileImageUrl,
      String address,
      Point location,
      List<ItemSimple> items});

  @override
  $PointCopyWith<$Res> get location;
}

/// @nodoc
class __$$StoreSimpleImplCopyWithImpl<$Res>
    extends _$StoreSimpleCopyWithImpl<$Res, _$StoreSimpleImpl>
    implements _$$StoreSimpleImplCopyWith<$Res> {
  __$$StoreSimpleImplCopyWithImpl(
      _$StoreSimpleImpl _value, $Res Function(_$StoreSimpleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profileImageUrl = null,
    Object? address = null,
    Object? location = null,
    Object? items = null,
  }) {
    return _then(_$StoreSimpleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Point,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemSimple>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreSimpleImpl implements _StoreSimple {
  const _$StoreSimpleImpl(
      {required this.id,
      required this.name,
      required this.profileImageUrl,
      required this.address,
      required this.location,
      required final List<ItemSimple> items})
      : _items = items;

  factory _$StoreSimpleImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreSimpleImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String profileImageUrl;
  @override
  final String address;
  @override
  final Point location;
  final List<ItemSimple> _items;
  @override
  List<ItemSimple> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'StoreSimple(id: $id, name: $name, profileImageUrl: $profileImageUrl, address: $address, location: $location, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreSimpleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, profileImageUrl,
      address, location, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreSimpleImplCopyWith<_$StoreSimpleImpl> get copyWith =>
      __$$StoreSimpleImplCopyWithImpl<_$StoreSimpleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreSimpleImplToJson(
      this,
    );
  }
}

abstract class _StoreSimple implements StoreSimple {
  const factory _StoreSimple(
      {required final int id,
      required final String name,
      required final String profileImageUrl,
      required final String address,
      required final Point location,
      required final List<ItemSimple> items}) = _$StoreSimpleImpl;

  factory _StoreSimple.fromJson(Map<String, dynamic> json) =
      _$StoreSimpleImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get profileImageUrl;
  @override
  String get address;
  @override
  Point get location;
  @override
  List<ItemSimple> get items;
  @override
  @JsonKey(ignore: true)
  _$$StoreSimpleImplCopyWith<_$StoreSimpleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoreDetail _$StoreDetailFromJson(Map<String, dynamic> json) {
  return _StoreDetail.fromJson(json);
}

/// @nodoc
mixin _$StoreDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  Point get location => throw _privateConstructorUsedError;
  List<ItemSimple> get items => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get oneLineIntroduce => throw _privateConstructorUsedError;
  String get introduce => throw _privateConstructorUsedError;
  String get operationTime => throw _privateConstructorUsedError;
  String get breakTime => throw _privateConstructorUsedError;
  String get lastOrderTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoreDetailCopyWith<StoreDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreDetailCopyWith<$Res> {
  factory $StoreDetailCopyWith(
          StoreDetail value, $Res Function(StoreDetail) then) =
      _$StoreDetailCopyWithImpl<$Res, StoreDetail>;
  @useResult
  $Res call(
      {int id,
      String name,
      String profileImageUrl,
      String address,
      Point location,
      List<ItemSimple> items,
      String phone,
      String oneLineIntroduce,
      String introduce,
      String operationTime,
      String breakTime,
      String lastOrderTime});

  $PointCopyWith<$Res> get location;
}

/// @nodoc
class _$StoreDetailCopyWithImpl<$Res, $Val extends StoreDetail>
    implements $StoreDetailCopyWith<$Res> {
  _$StoreDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profileImageUrl = null,
    Object? address = null,
    Object? location = null,
    Object? items = null,
    Object? phone = null,
    Object? oneLineIntroduce = null,
    Object? introduce = null,
    Object? operationTime = null,
    Object? breakTime = null,
    Object? lastOrderTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Point,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemSimple>,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      oneLineIntroduce: null == oneLineIntroduce
          ? _value.oneLineIntroduce
          : oneLineIntroduce // ignore: cast_nullable_to_non_nullable
              as String,
      introduce: null == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
      operationTime: null == operationTime
          ? _value.operationTime
          : operationTime // ignore: cast_nullable_to_non_nullable
              as String,
      breakTime: null == breakTime
          ? _value.breakTime
          : breakTime // ignore: cast_nullable_to_non_nullable
              as String,
      lastOrderTime: null == lastOrderTime
          ? _value.lastOrderTime
          : lastOrderTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PointCopyWith<$Res> get location {
    return $PointCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreDetailImplCopyWith<$Res>
    implements $StoreDetailCopyWith<$Res> {
  factory _$$StoreDetailImplCopyWith(
          _$StoreDetailImpl value, $Res Function(_$StoreDetailImpl) then) =
      __$$StoreDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String profileImageUrl,
      String address,
      Point location,
      List<ItemSimple> items,
      String phone,
      String oneLineIntroduce,
      String introduce,
      String operationTime,
      String breakTime,
      String lastOrderTime});

  @override
  $PointCopyWith<$Res> get location;
}

/// @nodoc
class __$$StoreDetailImplCopyWithImpl<$Res>
    extends _$StoreDetailCopyWithImpl<$Res, _$StoreDetailImpl>
    implements _$$StoreDetailImplCopyWith<$Res> {
  __$$StoreDetailImplCopyWithImpl(
      _$StoreDetailImpl _value, $Res Function(_$StoreDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profileImageUrl = null,
    Object? address = null,
    Object? location = null,
    Object? items = null,
    Object? phone = null,
    Object? oneLineIntroduce = null,
    Object? introduce = null,
    Object? operationTime = null,
    Object? breakTime = null,
    Object? lastOrderTime = null,
  }) {
    return _then(_$StoreDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Point,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemSimple>,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      oneLineIntroduce: null == oneLineIntroduce
          ? _value.oneLineIntroduce
          : oneLineIntroduce // ignore: cast_nullable_to_non_nullable
              as String,
      introduce: null == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
      operationTime: null == operationTime
          ? _value.operationTime
          : operationTime // ignore: cast_nullable_to_non_nullable
              as String,
      breakTime: null == breakTime
          ? _value.breakTime
          : breakTime // ignore: cast_nullable_to_non_nullable
              as String,
      lastOrderTime: null == lastOrderTime
          ? _value.lastOrderTime
          : lastOrderTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreDetailImpl implements _StoreDetail {
  const _$StoreDetailImpl(
      {required this.id,
      required this.name,
      required this.profileImageUrl,
      required this.address,
      required this.location,
      required final List<ItemSimple> items,
      required this.phone,
      required this.oneLineIntroduce,
      required this.introduce,
      required this.operationTime,
      required this.breakTime,
      required this.lastOrderTime})
      : _items = items;

  factory _$StoreDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String profileImageUrl;
  @override
  final String address;
  @override
  final Point location;
  final List<ItemSimple> _items;
  @override
  List<ItemSimple> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String phone;
  @override
  final String oneLineIntroduce;
  @override
  final String introduce;
  @override
  final String operationTime;
  @override
  final String breakTime;
  @override
  final String lastOrderTime;

  @override
  String toString() {
    return 'StoreDetail(id: $id, name: $name, profileImageUrl: $profileImageUrl, address: $address, location: $location, items: $items, phone: $phone, oneLineIntroduce: $oneLineIntroduce, introduce: $introduce, operationTime: $operationTime, breakTime: $breakTime, lastOrderTime: $lastOrderTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.oneLineIntroduce, oneLineIntroduce) ||
                other.oneLineIntroduce == oneLineIntroduce) &&
            (identical(other.introduce, introduce) ||
                other.introduce == introduce) &&
            (identical(other.operationTime, operationTime) ||
                other.operationTime == operationTime) &&
            (identical(other.breakTime, breakTime) ||
                other.breakTime == breakTime) &&
            (identical(other.lastOrderTime, lastOrderTime) ||
                other.lastOrderTime == lastOrderTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      profileImageUrl,
      address,
      location,
      const DeepCollectionEquality().hash(_items),
      phone,
      oneLineIntroduce,
      introduce,
      operationTime,
      breakTime,
      lastOrderTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreDetailImplCopyWith<_$StoreDetailImpl> get copyWith =>
      __$$StoreDetailImplCopyWithImpl<_$StoreDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreDetailImplToJson(
      this,
    );
  }
}

abstract class _StoreDetail implements StoreDetail {
  const factory _StoreDetail(
      {required final int id,
      required final String name,
      required final String profileImageUrl,
      required final String address,
      required final Point location,
      required final List<ItemSimple> items,
      required final String phone,
      required final String oneLineIntroduce,
      required final String introduce,
      required final String operationTime,
      required final String breakTime,
      required final String lastOrderTime}) = _$StoreDetailImpl;

  factory _StoreDetail.fromJson(Map<String, dynamic> json) =
      _$StoreDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get profileImageUrl;
  @override
  String get address;
  @override
  Point get location;
  @override
  List<ItemSimple> get items;
  @override
  String get phone;
  @override
  String get oneLineIntroduce;
  @override
  String get introduce;
  @override
  String get operationTime;
  @override
  String get breakTime;
  @override
  String get lastOrderTime;
  @override
  @JsonKey(ignore: true)
  _$$StoreDetailImplCopyWith<_$StoreDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
