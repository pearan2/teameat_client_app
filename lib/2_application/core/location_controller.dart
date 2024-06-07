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
  late LocationData _data;

  LocationData? get data => _isInitialized ? _data : null;
  bool get isInitialized => _isInitialized;

  void _locationDataListener(LocationData locationData) {
    _data = locationData;
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
    _location.changeSettings(
        interval: locationUpdateIntervalSec * 1000); // 10초에 한번 업데이트
    _location.onLocationChanged.listen(_locationDataListener);
    _data = await _location.getLocation();
    _isInitialized = true;
  }
}
