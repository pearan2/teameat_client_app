import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TENetworkCacheImage extends StatelessWidget {
  final String url;
  final double? width;

  final double borderRadius;
  final double ratio;

  const TENetworkCacheImage({
    super.key,
    required this.url,
    this.width,
    this.borderRadius = 0,
    this.ratio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidth = width;
    final imageHeight = width == null ? null : width! / ratio;

    return ExtendedImage.network(
      url,
      width: imageWidth,
      height: imageHeight,
      borderRadius: BorderRadius.circular(borderRadius),
      fit: BoxFit.cover,
      cache: true,
      retries: 3, // 3회까지 리트라이
      timeLimit: const Duration(seconds: 5), // 5초 내로 불러오지 못하면 리트라이
      loadStateChanged: (state) {
        switch (state) {
          // ignore: constant_pattern_never_matches_value_type
          case LoadState.loading:
            return const Center(
              child: TELoading(),
            );
          // ignore: constant_pattern_never_matches_value_type
          case LoadState.failed:
            return Center(
              child: DS.image.mainIconWithText,
            );
        }
      },
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
            .map((e) =>
                TENetworkCacheImage(key: ObjectKey(e), url: e, width: width))
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

class TENetworkImage extends StatelessWidget {
  final String url;
  final double size;
  final double borderRadius;

  const TENetworkImage({
    super.key,
    required this.url,
    required this.size,
    this.borderRadius = 300,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
