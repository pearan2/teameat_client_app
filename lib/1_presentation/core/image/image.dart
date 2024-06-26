import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image_viewer.dart';
import 'package:teameat/main.dart';

class TECacheImage extends StatelessWidget {
  final dynamic src;
  final double? width;

  final double borderRadius;
  final double ratio;

  const TECacheImage({
    super.key,
    required this.src,
    this.width,
    this.borderRadius = 0,
    this.ratio = 1.0,
  }) : assert((src is String) | (src is Uint8List) | (src is File),
            'invalid src provided, src is (String | Uint8List | File)');

  Widget _getImageBuilder() {
    if (src is String) {
      return ExtendedImage.network(
        src, width: width,
        fit: BoxFit.cover,
        cache: true,
        retries: 3, // 3회까지 리트라이
        timeLimit: const Duration(seconds: 5), // 5초 내로 불러오지 못하면 리트라이
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return const Center(child: TELoading());
            case LoadState.failed:
              return Center(child: DS.image.mainIconWithText);
            case LoadState.completed:
              return null;
          }
        },
      );
    } else if (src is Uint8List) {
      return ExtendedImage.memory(
        src,
        width: width,
        fit: BoxFit.cover,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return const Center(child: TELoading());
            case LoadState.failed:
              return Center(child: DS.image.mainIconWithText);
            case LoadState.completed:
              return null;
          }
        },
      );
    } else if (src is File) {
      return ExtendedImage.file(
        src,
        width: width,
        fit: BoxFit.cover,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return const Center(child: TELoading());
            case LoadState.failed:
              return Center(child: DS.image.mainIconWithText);
            case LoadState.completed:
              return null;
          }
        },
      );
    } else {
      throw 'invalid src provided, src is (String | Uint8List | File)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: width == null ? null : width! / ratio,
        child: AspectRatio(
          aspectRatio: ratio,
          child: _getImageBuilder(),
        ),
      ),
    );
  }
}

class TEImageCarouselCounter extends StatelessWidget {
  final int total;
  final int now;

  const TEImageCarouselCounter({
    super.key,
    required this.total,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: DS.space.tiny,
        horizontal: DS.space.xSmall,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        color: DS.color.background800,
      ),
      child: Text(
        '$now/$total',
        textAlign: TextAlign.center,
        style: DS.textStyle.paragraph3
            .copyWith(color: DS.color.background000, height: 1),
      ),
    );
  }
}

class TEImageCarousel extends StatefulWidget {
  final double width;
  final List<dynamic> imageSrcs;
  final double ratio;
  final Widget? bottomLeft;

  const TEImageCarousel({
    super.key,
    required this.width,
    required this.imageSrcs,
    this.ratio = 1 / 1,
    this.bottomLeft,
  });

  @override
  State<TEImageCarousel> createState() => _TEImageCarouselState();
}

class _TEImageCarouselState extends State<TEImageCarousel> {
  int nowImageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.width / widget.ratio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            items: widget.imageSrcs
                .map(
                  (e) => TECacheImage(
                    key: ObjectKey(e),
                    src: e,
                    width: widget.width,
                    ratio: widget.ratio,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) =>
                  setState(() => nowImageIdx = index),
              viewportFraction: 1.0,
              aspectRatio: widget.ratio,
            ),
          ),
          Positioned(
            right: DS.space.tiny + AppWidget.horizontalPadding,
            bottom: DS.space.tiny,
            child: TEImageCarouselCounter(
              now: nowImageIdx + 1,
              total: widget.imageSrcs.length,
            ),
          ),
          Positioned(
              left: AppWidget.horizontalPadding,
              bottom: 0,
              child: widget.bottomLeft ?? const SizedBox()),
        ],
      ),
    );
  }
}

class TEImageListViewer extends StatelessWidget {
  final List<dynamic> imageSrcs;
  final double imageRatio;
  final double imagePreviewWidth;

  const TEImageListViewer(
      {super.key,
      required this.imageSrcs,
      required this.imageRatio,
      this.imagePreviewWidth = 80.0});

  Widget _buildItem(final dynamic imageSrc) {
    return TEonTap(
      onTap: () => showMultiImageViewer(
          imageSrc: imageSrc, imageSrcs: imageSrcs, imageRatio: imageRatio),
      child: Container(
        width: imagePreviewWidth,
        height: imagePreviewWidth / imageRatio,
        decoration:
            BoxDecoration(border: Border.all(color: DS.color.background300)),
        child: TECacheImage(
          src: imageSrc,
          width: imagePreviewWidth,
          ratio: imageRatio,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = imagePreviewWidth / imageRatio;
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (_, idx) => _buildItem(imageSrcs[idx]),
        separatorBuilder: (_, __) => DS.space.hXTiny,
        itemCount: imageSrcs.length,
      ),
    );
  }
}
