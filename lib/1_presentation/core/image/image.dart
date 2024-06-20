import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

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

class TEImageCarousel extends StatelessWidget {
  final double width;
  final List<String> imageUrls;

  const TEImageCarousel(
      {super.key, required this.width, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return PageLoadingWrapper(
      child: CarouselSlider(
        items: imageUrls
            .map((e) => TECacheImage(key: ObjectKey(e), src: e, width: width))
            .toList(),
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 1.0,
          aspectRatio: 1.0,
        ),
      ),
    );
  }
}
