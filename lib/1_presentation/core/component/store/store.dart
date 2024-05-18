import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreSimpleInfoRow extends GetView<IReact> {
  final int storeId;
  final String profileImageUrl;
  final String name;
  final String subInfo;
  final bool isButton;

  const StoreSimpleInfoRow({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.subInfo,
    required this.storeId,
    this.isButton = true,
  });

  Widget _buildButton() {
    if (!isButton) return const SizedBox();
    return const Icon(Icons.keyboard_arrow_right);
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () {
        if (isButton) {
          controller.toStoreDetail(storeId);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: TENetworkImage(
                url: profileImageUrl, width: DS.getSpace().large),
          ),
          DS.getSpace().hTiny,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: DS
                      .getTextStyle()
                      .paragraph2
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DS.getSpace().vXTiny,
                Text(
                  subInfo,
                  overflow: TextOverflow.ellipsis,
                  style: DS.getTextStyle().caption1,
                ),
              ],
            ),
          ),
          _buildButton(),
        ],
      ),
    );
  }
}

class StoreImageCarousel extends StatelessWidget {
  final double width;
  final double height;

  final StoreDetail store;

  const StoreImageCarousel({
    super.key,
    required this.width,
    required this.height,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: store.imageUrls
          .map((e) => PageLoadingWrapper(
                child: TENetworkImage(url: e, width: width),
              ))
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

class StoreInfoRow extends StatelessWidget {
  final Widget icon;
  final String title;
  final String content;

  const StoreInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: DS.getSpace().xTiny),
          width: DS.getSpace().large + DS.getSpace().medium,
          child: Text(
            title,
            style: DS.getTextStyle().paragraph3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(top: DS.getSpace().xTiny),
          child: Text(
            content,
            style: DS
                .getTextStyle()
                .paragraph3
                .copyWith(color: DS.getColor().background600),
          ),
        ))
      ],
    );
  }
}
