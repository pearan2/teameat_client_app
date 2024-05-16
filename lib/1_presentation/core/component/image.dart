import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TENetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double? height;
  final double borderRadius;

  const TENetworkImage({
    super.key,
    required this.url,
    required this.width,
    this.borderRadius = 0,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        width: width,
        height: height ?? width,
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
    );
  }
}
