import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: child,
                );
              } else {
                return child;
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return SizedBox(
                width: width,
                height: height ?? width,
                child: const Center(
                  child: Text(
                    'Oops! Something went wrong',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
