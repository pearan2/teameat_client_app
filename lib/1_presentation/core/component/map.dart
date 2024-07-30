import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  final bool gestureEnabled;
  final void Function(int id)? onStoreSelected;

  const TEStoreMap._({
    super.key,
    this.height,
    required this.defaultCameraCenter,
    required this.stores,
    required this.defaultZoomLevel,
    required this.isLoading,
    this.gestureEnabled = false,
    this.onStoreSelected,
  });

  factory TEStoreMap.single({
    double? height,
    required StorePoint store,
    required bool isLoading,
    double defaultZoomLevel = 15,
  }) {
    return TEStoreMap._(
      isLoading: isLoading,
      height: height,
      defaultCameraCenter: store.location,
      stores: [store],
      defaultZoomLevel: defaultZoomLevel,
      key: ValueKey(store.id),
      gestureEnabled: false,
      onStoreSelected: print,
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
    if (!listEquals(oldWidget.stores, widget.stores)) {
      _addAllStoreMarkers();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _init(NaverMapController nController) async {
    isInit = true;
    controller = nController;
    _addAllStoreMarkers();
  }

  Future<Widget> _makeMakerIconWidget(StorePoint store) async {
    if (!mounted) return const SizedBox();
    await precacheImage(NetworkImage(store.profileImageUrl), context);
    if (!mounted) return const SizedBox();
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
    final marker = NMarker(
      id: store.id.toString(),
      position: store.location.toNLatLng(),
    );
    if (mounted) {
      final overlayImage = await NOverlayImage.fromWidget(
        widget: Container(child: child),
        size: Size(DS.space.medium, DS.space.large),
        context: context,
      );
      marker.setIcon(overlayImage);
    }
    marker.setOnTapListener(
        (m) => widget.onStoreSelected?.call(int.parse(m.info.id)));
    return marker;
  }

  Future<void> _addAllStoreMarkers() async {
    if (!isInit || !mounted) {
      return;
    }
    final markers = await Future.wait(widget.stores
        .map((s) async => _makeMarker(await _makeMakerIconWidget(s), s)));
    if (!mounted) return;
    _addAllMarkers(markers.toSet());
  }

  Future<void> _addAllMarkers(Set<NMarker> markers) async {
    if (!mounted) return;
    return controller.addOverlayAll(markers);
  }

  void _onCameraIdle() {
    // print('onCameraIdle');
  }

  void _onCameraChanged() {
    // print('onCameraChanged');
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
        onCameraChange: (reason, animated) => _onCameraChanged(),
        onCameraIdle: _onCameraIdle,
        forceGesture: widget.gestureEnabled,
        options: NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(
            target: widget.defaultCameraCenter.toNLatLng(),
            zoom: widget.defaultZoomLevel,
          ),
          minZoom: 12,
          maxZoom: 18,
          zoomGesturesFriction: 0.1,
          zoomGesturesEnable: widget.gestureEnabled,
          stopGesturesEnable: widget.gestureEnabled,
          tiltGesturesEnable: widget.gestureEnabled,
          scrollGesturesEnable: widget.gestureEnabled,
          rotationGesturesEnable: widget.gestureEnabled,
        ),
        onMapReady: (nController) {
          _init(nController);
        },
      ),
    );
  }
}

class GoToMap extends StatelessWidget {
  final StorePoint store;
  final String name;
  const GoToMap({super.key, required this.store, required this.name});

  Future<void> goToMap() async {
    late final bool isLaunched;
    if (store.naverMapPlaceId == null || store.naverMapPlaceId!.isEmpty) {
      isLaunched = await launchUrlString(
          'nmap://place?lat=${store.location.latitude}&lng=${store.location.longitude}&name=$name');
    } else {
      isLaunched =
          await launchUrlString('nmap://place?id=${store.naverMapPlaceId}');
    }

    if (!isLaunched) {
      showError(DS.text.mapAppNotLaunched);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: goToMap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: DS.space.xxTiny, horizontal: DS.space.xBase),
        decoration: BoxDecoration(
            border: Border.all(color: DS.color.background300),
            borderRadius: BorderRadius.circular(DS.space.xSmall)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DS.image.naverMap,
            DS.space.hXTiny,
            Text(DS.text.goToMapApp, style: DS.textStyle.caption2.b800),
          ],
        ),
      ),
    );
  }
}

class TEMapToolbar extends StatelessWidget {
  final StorePoint store;
  final String name;
  final String address;
  const TEMapToolbar(
      {super.key,
      required this.store,
      required this.name,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TETextCopyButton(textData: address)),
        DS.space.hTiny,
        GoToMap(store: store, name: name),
      ],
    );
  }
}
