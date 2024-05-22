import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TENetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double borderRadius;
  final double ratio;

  const TENetworkImage({
    super.key,
    required this.url,
    this.width,
    this.borderRadius = 0,
    this.height,
    this.ratio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width ?? width,
        height: height ?? height,
        child: AspectRatio(
          aspectRatio: ratio,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final larger = max(constraints.maxHeight, constraints.maxWidth);
              return Image.network(
                key: ValueKey('$url$larger'),
                url,
                fit: BoxFit.cover,
                cacheWidth: (larger).toInt(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return TEShimmer.fromSize(width: larger, height: larger);
                  } else {
                    return child;
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(DS.text.errorOccurred),
                  );
                },
              );
            },
          ),
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
    return CarouselSlider(
      items: imageUrls
          .map((e) => TENetworkImage(key: ObjectKey(e), url: e, width: width))
          .toList(),
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        aspectRatio: 1.0,
      ),
    );
  }
}
