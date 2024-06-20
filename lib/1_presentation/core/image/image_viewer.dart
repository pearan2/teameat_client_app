import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class ImageViewPage extends StatelessWidget {
  final String imageUrl;
  final bool isNetworkImage;

  const ImageViewPage({
    super.key,
    required this.imageUrl,
    this.isNetworkImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => Get.back(),
            icon: Icon(Icons.close, color: DS.color.background000),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: ImageViewPageBody(
            imageUrl: imageUrl, isNetworkImage: isNetworkImage),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class ImageViewPageBody extends StatelessWidget {
  final String imageUrl;

  final bool isNetworkImage;

  const ImageViewPageBody({
    super.key,
    required this.imageUrl,
    required this.isNetworkImage,
  });

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage) {
      return Center(
        child: PhotoView(
          maxScale: PhotoViewComputedScale.contained * 8,
          minScale: PhotoViewComputedScale.contained * 1.0,
          initialScale: PhotoViewComputedScale.contained * 1.0,
          imageProvider: NetworkImage(imageUrl),
        ),
      );
    } else {
      return Center(
        child: PhotoView(
          maxScale: PhotoViewComputedScale.contained * 8,
          minScale: PhotoViewComputedScale.contained * 1.0,
          initialScale: PhotoViewComputedScale.contained * 1.0,
          imageProvider: AssetImage(imageUrl),
        ),
      );
    }
  }
}

class ImageMultiViewPage extends StatefulWidget {
  final dynamic nowImageSrc;
  final List<dynamic> imageSrcs;
  final Function(int oldIdx, int newIdx)? onReorder;
  final Function(int targetIdx)? onRemove;
  final double ratio;

  const ImageMultiViewPage({
    super.key,
    required this.nowImageSrc,
    required this.imageSrcs,
    required this.ratio,
    this.onReorder,
    this.onRemove,
  });

  @override
  State<ImageMultiViewPage> createState() => _ImageMultiViewPageState();
}

class _ImageMultiViewPageState extends State<ImageMultiViewPage>
    with TickerProviderStateMixin {
  final imageWidth = DS.space.large + DS.space.base;
  late final imageHeight = imageWidth / widget.ratio;

  late var imageSrcs = [...widget.imageSrcs];
  late int nowIdx = widget.imageSrcs.indexOf(widget.nowImageSrc);

  bool isInitialized = false;
  late TabController tabController;

  void onReorder(int lhs, int rhs) {
    if (lhs < rhs) {
      rhs--;
    }
    if (lhs < 0 ||
        lhs >= imageSrcs.length ||
        rhs < 0 ||
        rhs >= imageSrcs.length) {
      return;
    }
    final newImageSrcs = [...imageSrcs];

    final lhsTarget = newImageSrcs.removeAt(lhs);
    newImageSrcs.insert(rhs, lhsTarget);
    setState(() {
      imageSrcs = newImageSrcs;
      tabController.index = rhs;
      widget.onReorder?.call(lhs, rhs);
    });
  }

  void onRemove(int idx) {
    final newImageSrcs = [...imageSrcs]..removeAt(idx);
    final int nextIdx;
    if (idx >= newImageSrcs.length) {
      nextIdx = newImageSrcs.length - 1;
    } else {
      nextIdx = idx;
    }
    if (newImageSrcs.isEmpty) {
      widget.onRemove?.call(idx);
      Get.back();
      return;
    }

    setState(() {
      imageSrcs = newImageSrcs;
      initTabController(nextIdx);
      widget.onRemove?.call(nextIdx);
    });
  }

  void initTabController(int idx) {
    if (isInitialized) {
      tabController.removeListener(_tabListener);
      tabController.dispose();
    }
    tabController = TabController(
      length: imageSrcs.length,
      vsync: this,
      initialIndex: idx,
      animationDuration: Duration.zero,
    );
    tabController.addListener(_tabListener);
  }

  @override
  void initState() {
    super.initState();
    initTabController(nowIdx);
    isInitialized = true;
  }

  @override
  void dispose() {
    tabController.removeListener(_tabListener);
    tabController.dispose();
    super.dispose();
  }

  void _tabListener() {
    setState(() {
      nowIdx = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => Get.back(),
            icon: Icon(Icons.close, color: DS.color.background000),
          ),
          centerTitle: true,
          title: Text(
            '${nowIdx + 1}/${imageSrcs.length}',
            style: DS.textStyle.title3.copyWith(color: DS.color.background000),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TabBarView(
                controller: tabController,
                dragStartBehavior: DragStartBehavior.down,
                children: imageSrcs
                    .map((e) => ImageMultiViewPageBody(imageSrc: e))
                    .toList(),
              ),
            ),
            LimitedBox(
              maxHeight: imageHeight,
              maxWidth: Get.mediaQuery.size.width,
              child: widget.onRemove == null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: DS.space.xSmall),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, idx) => _buildItem(imageSrcs[idx], idx),
                      itemCount: imageSrcs.length,
                    )
                  : ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: DS.space.xSmall),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, idx) => _buildItem(imageSrcs[idx], idx),
                      itemCount: imageSrcs.length,
                      onReorder: onReorder,
                    ),
            ),
            DS.space.vMedium,
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildItem(dynamic imageSrc, int idx) {
    Widget buildImage() {
      return TEonTap(
        onTap: () => tabController.animateTo(idx),
        child: TECacheImage(
          src: imageSrc,
          borderRadius: DS.space.xTiny,
          ratio: widget.ratio,
          width: DS.space.large + DS.space.base,
        ),
      );
    }

    return Stack(
      key: ObjectKey(imageSrc),
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: DS.space.xTiny),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DS.space.xTiny),
            border: Border.all(
                color: idx == nowIdx
                    ? DS.color.background000
                    : DS.color.background800,
                width: DS.space.xxTiny),
          ),
          child: buildImage(),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Visibility(
            visible: widget.onRemove != null,
            child: TEonTap(
              onTap: () => onRemove(idx),
              child: Container(
                width: DS.space.base,
                height: DS.space.base,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DS.space.xxTiny),
                  border: Border.all(
                    width: DS.space.xxTiny,
                    color: DS.color.background000,
                  ),
                  color: DS.color.background800,
                ),
                child: Icon(
                  Icons.delete,
                  color: DS.color.background000,
                  size: DS.space.xBase,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageMultiViewPageBody extends StatelessWidget {
  final dynamic imageSrc;

  const ImageMultiViewPageBody({
    super.key,
    required this.imageSrc,
  });

  ImageProvider getProvider() {
    if (imageSrc is String) {
      return NetworkImage(imageSrc);
    } else if (imageSrc is Uint8List) {
      return MemoryImage(imageSrc);
    } else if (imageSrc is File) {
      return FileImage(imageSrc);
    } else {
      throw 'invalid src provided, src is (String | Uint8List | File)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhotoView(
        maxScale: PhotoViewComputedScale.contained * 8,
        minScale: PhotoViewComputedScale.contained * 1.0,
        initialScale: PhotoViewComputedScale.contained * 1.0,
        imageProvider: getProvider(),
      ),
    );
  }
}

void showImageViewer(String imageUrl, {bool isNetworkImage = true}) {
  Get.bottomSheet(
    ImageViewPage(
      imageUrl: imageUrl,
      isNetworkImage: isNetworkImage,
    ),
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    enterBottomSheetDuration: Duration.zero,
    exitBottomSheetDuration: Duration.zero,
  );
}

void showMultiImageEditViewer({
  required dynamic imageSrc,
  required List<dynamic> imageSrcs,
  required double imageRatio,
  required Function(int oldIdx, int newIdx) onReorder,
  required Function(int targetIdx) onRemove,
}) {
  Get.bottomSheet(
    ImageMultiViewPage(
      nowImageSrc: imageSrc,
      imageSrcs: imageSrcs,
      ratio: imageRatio,
      onRemove: onRemove,
      onReorder: onReorder,
    ),
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    enterBottomSheetDuration: Duration.zero,
    exitBottomSheetDuration: Duration.zero,
  );
}

void showMultiImageViewer({
  required dynamic imageSrc,
  required List<dynamic> imageSrcs,
  required double imageRatio,
}) {
  Get.bottomSheet(
    ImageMultiViewPage(
      nowImageSrc: imageSrc,
      imageSrcs: imageSrcs,
      ratio: imageRatio,
    ),
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    enterBottomSheetDuration: Duration.zero,
    exitBottomSheetDuration: Duration.zero,
  );
}
