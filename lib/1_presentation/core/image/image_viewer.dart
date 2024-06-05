// import 'package:ali/0_presentation/core/ali_design_system.dart';
// import 'package:ali/0_presentation/core/utils/image/image_box.dart';
// import 'package:ali/0_presentation/core/utils/util.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';

// class ImageViewPage extends StatelessWidget {
//   final String imageUrl;
//   final bool isNetworkImage;

//   const ImageViewPage({
//     Key? key,
//     required this.imageUrl,
//     this.isNetworkImage = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
//       color: Colors.black,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onPressed: () => Get.back(),
//             icon: Icon(Icons.close, color: AliColorScheme.grayScaleWhite),
//           ),
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//         ),
//         body: ImageViewPageBody(
//             imageUrl: imageUrl, isNetworkImage: isNetworkImage),
//         backgroundColor: Colors.black,
//       ),
//     );
//   }
// }

// class ImageViewPageBody extends StatelessWidget {
//   final String imageUrl;

//   final bool isNetworkImage;

//   const ImageViewPageBody({
//     Key? key,
//     required this.imageUrl,
//     required this.isNetworkImage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (isNetworkImage) {
//       return Center(
//         child: PhotoView(
//           maxScale: PhotoViewComputedScale.contained * 8,
//           minScale: PhotoViewComputedScale.contained * 1.0,
//           initialScale: PhotoViewComputedScale.contained * 1.0,
//           imageProvider: NetworkImage(imageUrl),
//         ),
//       );
//     } else {
//       return Center(
//         child: PhotoView(
//           maxScale: PhotoViewComputedScale.contained * 8,
//           minScale: PhotoViewComputedScale.contained * 1.0,
//           initialScale: PhotoViewComputedScale.contained * 1.0,
//           imageProvider: AssetImage(imageUrl),
//         ),
//       );
//     }
//   }
// }

// class ImageMultiViewPage extends StatefulWidget {
//   final String nowImageUrl;
//   final List<String> imageUrls;

//   const ImageMultiViewPage({
//     Key? key,
//     required this.nowImageUrl,
//     required this.imageUrls,
//   }) : super(key: key);

//   @override
//   State<ImageMultiViewPage> createState() => _ImageMultiViewPageState();
// }

// class _ImageMultiViewPageState extends State<ImageMultiViewPage>
//     with SingleTickerProviderStateMixin {
//   late String nowImageUrl = widget.nowImageUrl;

//   late int nowIdx = widget.imageUrls.indexOf(nowImageUrl);

//   late final TabController tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(
//         length: widget.imageUrls.length, vsync: this, initialIndex: nowIdx);
//     tabController.addListener(_tabListener);
//   }

//   @override
//   void dispose() {
//     tabController.removeListener(_tabListener);
//     tabController.dispose();
//     super.dispose();
//   }

//   void _tabListener() {
//     setState(() {
//       nowIdx = tabController.index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
//       color: Colors.black,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onPressed: () => Get.back(),
//             icon: Icon(Icons.close, color: AliColorScheme.grayScaleWhite),
//           ),
//           centerTitle: true,
//           title: Text(
//             '${nowIdx + 1}/${widget.imageUrls.length}',
//             style: AliTextTheme.h3.copyWith(
//               height: 1,
//               color: AliColorScheme.grayScaleWhite,
//             ),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//         ),
//         body: Stack(
//           children: [
//             TabBarView(
//               controller: tabController,
//               dragStartBehavior: DragStartBehavior.down,
//               children: widget.imageUrls
//                   .map((e) => ImageMultiViewPageBody(imageUrl: e))
//                   .toList(),
//             ),
//             Positioned(
//               bottom: AliSpacing.xBase,
//               child: LimitedBox(
//                 maxHeight: 72,
//                 maxWidth: Get.mediaQuery.size.width,
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   padding: EdgeInsets.symmetric(horizontal: AliSpacing.xBase),
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (_, idx) =>
//                       _buildItem(widget.imageUrls[idx], idx),
//                   separatorBuilder: (_, __) => AliSpacing.hTiny,
//                   itemCount: widget.imageUrls.length,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.black,
//       ),
//     );
//   }

//   Widget _buildItem(String imageUrl, int idx) {
//     Widget _buildImage() {
//       return AliImageBox(
//         borderRadius: 4,
//         imagePath: imageUrl,
//         onTap: () => tabController.animateTo(idx),
//         width: 72,
//         height: 72,
//       );
//     }

//     if (idx == nowIdx) {
//       return AliBox(
//         padding: EdgeInsets.zero,
//         borderRadius: 4,
//         borderColor: AliColorScheme.grayScaleWhite,
//         borderWidth: 2,
//         child: _buildImage(),
//       );
//     } else {
//       return _buildImage();
//     }
//   }
// }

// class ImageMultiViewPageBody extends StatelessWidget {
//   final String imageUrl;

//   const ImageMultiViewPageBody({
//     Key? key,
//     required this.imageUrl,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: PhotoView(
//         maxScale: PhotoViewComputedScale.contained * 8,
//         minScale: PhotoViewComputedScale.contained * 1.0,
//         initialScale: PhotoViewComputedScale.contained * 1.0,
//         imageProvider: NetworkImage(imageUrl),
//       ),
//     );
//   }
// }

// void showImageViewer(String imageUrl, {bool isNetworkImage = true}) {
//   Get.bottomSheet(
//     ImageViewPage(
//       imageUrl: imageUrl,
//       isNetworkImage: isNetworkImage,
//     ),
//     isScrollControlled: true,
//     isDismissible: false,
//     enableDrag: false,
//     enterBottomSheetDuration: Duration.zero,
//     exitBottomSheetDuration: Duration.zero,
//   );
// }

// void showMultiImageViewer(String imageUrl, List<String> ImageUrls,
//     {bool isNetworkImage = true}) {
//   Get.bottomSheet(
//     ImageMultiViewPage(
//       nowImageUrl: imageUrl,
//       imageUrls: ImageUrls,
//     ),
//     isScrollControlled: true,
//     isDismissible: false,
//     enableDrag: false,
//     enterBottomSheetDuration: Duration.zero,
//     exitBottomSheetDuration: Duration.zero,
//   );
// }
