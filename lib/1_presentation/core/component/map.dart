import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/3_domain/store/store.dart';

extension _TEPointExtension on Point {
  NLatLng toNLatLng() {
    return NLatLng(latitude, longitude);
  }
}

class TEStoreMap extends StatefulWidget {
  final double? height;
  final bool isLoading;
  final Point defaultCameraCenter;
  final List<StorePoint> stores;
  final double defaultZoomLevel;

  const TEStoreMap._(
      {super.key,
      this.height,
      required this.defaultCameraCenter,
      required this.stores,
      required this.defaultZoomLevel,
      required this.isLoading});

  factory TEStoreMap.single(
      {double? height,
      required StorePoint store,
      required bool isLoading,
      double defaultZoomLevel = 15}) {
    return TEStoreMap._(
      isLoading: isLoading,
      height: height,
      defaultCameraCenter: store.location,
      stores: [store],
      defaultZoomLevel: defaultZoomLevel,
      key: ValueKey(store.id),
    );
  }

  @override
  State<TEStoreMap> createState() => _TEStoreMapState();
}

class _TEStoreMapState extends State<TEStoreMap> {
  late final NaverMapController controller;
  bool isInit = false;

  late bool isLoading = widget.isLoading;

  @override
  void didUpdateWidget(covariant TEStoreMap oldWidget) {
    if (oldWidget.isLoading != widget.isLoading) {
      setState(() => isLoading = widget.isLoading);
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _init(NaverMapController nController) async {
    isInit = true;
    controller = nController;
    final iconWidget = await _makeMakerIconWidget(widget.stores.first);
    final marker = await _makeMarker(iconWidget, widget.stores.first);
    _addAllMarkers({marker});
  }

  Future<Widget> _makeMakerIconWidget(StorePoint store) async {
    await precacheImage(NetworkImage(store.profileImageUrl), context);
    await precacheImage(
        const AssetImage('assets/image/map_marker.png'), context);
    return Stack(
      children: [
        Image.asset(
          'assets/image/map_marker.png',
          width: 32,
          height: 42,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Image.network(
                  store.profileImageUrl,
                  fit: BoxFit.cover,
                  width: 24,
                  height: 24,
                )),
          ),
        ),
      ],
    );
  }

  Future<NMarker> _makeMarker(Widget child, StorePoint store) async {
    final overlayImage = await NOverlayImage.fromWidget(
      widget: Container(child: child),
      size: Size(DS.space.medium, DS.space.large),
      context: context,
    );
    final marker = NMarker(
      id: store.id.toString(),
      position: store.location.toNLatLng(),
    );
    marker.setIcon(overlayImage);
    return marker;
  }

  Future<void> _addAllMarkers(Set<NMarker> markers) {
    return controller.addOverlayAll(markers);
  }

  @override
  void dispose() {
    if (isInit) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height ?? MediaQuery.of(context).size.height / 2;

    if (isLoading) {
      return TEShimmer.fromSize(width: double.infinity, height: height);
    }

    return SizedBox(
      height: height,
      child: NaverMap(
        forceGesture: true,
        options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
              target: widget.defaultCameraCenter.toNLatLng(),
              zoom: widget.defaultZoomLevel,
            ),
            zoomGesturesEnable: true,
            zoomGesturesFriction: 0.1),
        onMapReady: (nController) {
          _init(nController);
        },
      ),
    );
  }
}
