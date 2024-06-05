// import 'dart:io';
// import 'package:ali/0_presentation/core/utils/image/image_viewer.dart';
// import 'package:ali/0_presentation/core/utils/util.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class AliImageBox extends StatelessWidget {
//   final String? imagePath;
//   final File? imageFile;
//   final Widget? defaultImage;
//   final double borderRadius;
//   final double? width;
//   final double? height;
//   final int? cacheWidth;
//   final int? cacheHeight;
//   final void Function()? onTap;

//   const AliImageBox({
//     Key? key,
//     this.imagePath,
//     this.imageFile,
//     required this.borderRadius,
//     this.width,
//     this.height,
//     this.cacheHeight,
//     this.cacheWidth,
//     this.defaultImage,
//     this.onTap,
//   })  : assert(imagePath != null || imageFile != null || defaultImage != null,
//             'invalid params!'),
//         super(key: key);

//   Widget _buildImage() {
//     if (imagePath != null) {
//       return _buildNetWorkImage();
//     } else if (imageFile != null) {
//       return _buildFileImage();
//     } else if (defaultImage != null) {
//       return defaultImage!;
//     } else {
//       throw 'invalid params!';
//     }
//   }

//   Widget _buildNetWorkImage() {
//     return AliTap(
//       onTap: onTap ?? () => showImageViewer(imagePath!, isNetworkImage: true),
//       child: Image.network(
//         imagePath!,
//         fit: BoxFit.cover,
//         width: width,
//         height: height,
//         cacheWidth: cacheWidth,
//         cacheHeight: cacheHeight,
//         loadingBuilder: (_, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return AliShimmer(
//             width: width,
//             height: height,
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFileImage() {
//     return Image.file(
//       imageFile!,
//       fit: BoxFit.cover,
//       width: width,
//       height: height,
//       cacheWidth: cacheWidth,
//       cacheHeight: cacheHeight,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: _buildImage(),
//     );
//   }
// }

// class AliShimmer extends StatelessWidget {
//   final Color baseColor;
//   final Color highlightColor;
//   final double? width;
//   final double? height;

//   const AliShimmer({
//     Key? key,
//     this.baseColor = const Color(0xFF9D9593),
//     this.highlightColor = const Color(0xFFBAB1B0),
//     this.width,
//     this.height,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: baseColor,
//       highlightColor: highlightColor,
//       child: Container(
//         color: Colors.white,
//         width: width,
//         height: height,
//       ),
//     );
//   }
// }
