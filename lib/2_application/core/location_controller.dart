import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/3_domain/store/store.dart';

extension LocationDataExtension on LocationData {
  Point? toPoint() {
    if (latitude == null || longitude == null) return null;
    return Point(latitude: latitude!, longitude: longitude!);
  }
}

extension PermissionStatusExtension on PermissionStatus {
  bool isGranted() {
    return this == PermissionStatus.granted ||
        this == PermissionStatus.grantedLimited;
  }
}

class LocationController {
  static const int locationUpdateIntervalSec = 10;

  final _location = Location();
  bool _isInitialized = false;
  final _data = Rxn<LocationData>();

  LocationData? get data => _data.value;
  bool get isInitialized => _isInitialized;

  void _locationDataListener(LocationData locationData) {
    _isInitialized = true;
    _data.value = locationData;
  }

  LocationController() {
    _tryAutoInit();
  }

  Future<void> _loadLocalData({bool showTimeoutError = true}) async {
    _location.changeSettings(
        interval: locationUpdateIntervalSec * 5); // 5초에 한번 업데이트
    _location.onLocationChanged.listen(_locationDataListener);
    final ret = await Future.any([
      _location.getLocation(),
      Future.delayed(const Duration(seconds: 5), () => null)
    ]);
    if (ret == null) {
      if (showTimeoutError) {
        showError(DS.text.accessToLocationTimeout);
      }
      return;
    } else {
      _data.value = ret;
      _isInitialized = true;
    }
  }

  Future<void> _tryAutoInit() async {
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (!permissionGranted.isGranted()) {
      return;
    }
    return _loadLocalData(showTimeoutError: false);
  }

  Future<void> init() async {
    if (_isInitialized) return;

    if (!(await _location.serviceEnabled()) ||
        !(await _location.requestService())) {
      showError(DS.text.locationServiceDisabled);
      return;
    }
    PermissionStatus permissionGranted = await _location.hasPermission();

    if (!permissionGranted.isGranted()) {
      permissionGranted = await _location.requestPermission();
      if (!permissionGranted.isGranted()) {
        showError(DS.text.locationPermissionDenied);
        return;
      }
    }
    return _loadLocalData();
  }
}
