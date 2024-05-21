import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/3_domain/store/store.dart';

class TEStoreMap extends StatefulWidget {
  final double? height;
  final StorePoint center;
  final double defaultZoomLevel;

  const TEStoreMap({
    super.key,
    this.height,
    required this.center,
    this.defaultZoomLevel = 15.0,
  });

  @override
  State<TEStoreMap> createState() => _TEStoreMapState();
}

class _TEStoreMapState extends State<TEStoreMap> {
  @override
  void didUpdateWidget(covariant TEStoreMap oldWidget) {
    if (oldWidget.center != widget.center) {
      _init();
    }
    super.didUpdateWidget(oldWidget);
  }

  late final NaverMapController? controller;

  void _init() {
    controller?.clearOverlays();
    _tryMoveCameraPosition(widget.center);
    _tryAddMarker(widget.center);
  }

  void _tryMoveCameraPosition(StorePoint storePoint) {
    controller?.updateCamera(NCameraUpdate.fromCameraPosition(_centerCamera()));
  }

  Widget _icon(StorePoint storePoint, Size size) {
    return Column(
      children: [
        TENetworkImage(
          url: storePoint.profileImageUrl,
          width: size.width,
          height: size.height / 2,
          borderRadius: 300,
        ),
        Container(
          width: 10,
          height: size.height / 2,
          color: Colors.red,
        )
      ],
    );
  }

  Future<void> _tryAddMarker(StorePoint storePoint) async {
    final markerIconSize = Size(DS.getSpace().medium, DS.getSpace().medium * 2);

    final point = storePoint.location;
    final overlayImage = await NOverlayImage.fromWidget(
        widget: _icon(storePoint, markerIconSize),
        size: markerIconSize,
        context: context);
    final marker = NMarker(
      id: '${point.latitude.toString()}${point.longitude.toString()}',
      position: _fromPoint(point),
      icon: overlayImage,
    );
    controller?.addOverlay(marker);
  }

  NCameraPosition _centerCamera() {
    return NCameraPosition(
      target: _fromPoint(widget.center.location),
      zoom: widget.defaultZoomLevel,
    );
  }

  NLatLng _fromPoint(Point point) {
    return NLatLng(point.latitude, point.longitude);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height ?? MediaQuery.of(context).size.height / 2;

    return SizedBox(
      height: height,
      child: NaverMap(
        forceGesture: true,
        options: NaverMapViewOptions(
            initialCameraPosition: _centerCamera(),
            zoomGesturesEnable: true,
            zoomGesturesFriction: 0.1),
        onMapReady: (nController) {
          controller = nController;
          _init();
        },
      ),
    );
  }
}
