import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/99_util/color.dart';

class TEAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double defaultHeight = 48.0;

  @override
  final Size preferredSize;
  final void Function()? leadingIconOnPressed;
  final Widget? action;
  final void Function()? homeOnPressed;
  final String? title;
  final Widget? titleWidget;
  final Color? backgroundColor;
  final Color? leadingIconColor;
  final bool withLeading;

  TEAppBar({
    super.key,
    this.leadingIconOnPressed,
    this.title,
    this.titleWidget,
    this.homeOnPressed,
    this.action,
    this.backgroundColor,
    this.leadingIconColor,
    this.withLeading = true,
    double? height,
  })  : assert(!(action != null && homeOnPressed != null)),
        assert(!(title != null && titleWidget != null)),
        preferredSize = Size.fromHeight(height ?? TEAppBar.defaultHeight);

  List<Widget> _buildActions() {
    if (action != null) {
      return [
        action!,
        DS.space.hSmall,
      ];
    }

    if (homeOnPressed == null) return [];
    return [
      TEonTap(onTap: homeOnPressed!, child: Center(child: DS.image.iconHome)),
      DS.space.hSmall,
    ];
  }

  Widget? _buildTitle(double titleMaxWidth) {
    if (titleWidget != null) {
      return titleWidget;
    }
    if (title == null) return null;
    final titleWidth = Container(
      alignment: Alignment.center,
      width: titleMaxWidth,
      child: Text(
        title!,
        overflow: TextOverflow.ellipsis,
        style: DS.textStyle.paragraph2.copyWith(fontWeight: FontWeight.bold),
      ),
    );
    return titleWidth;
  }

  Widget? _buildLeading() {
    if (leadingIconOnPressed == null) {
      return null;
    } else {
      return IconButton(
          onPressed: leadingIconOnPressed,
          icon: DS.image.leftArrowInBox(
              color: leadingIconColor ?? DS.color.background800));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: withLeading,
      backgroundColor: backgroundColor ?? DS.color.background000,
      surfaceTintColor: DS.color.background000,
      leading: _buildLeading(),
      actions: _buildActions(),
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: _buildTitle(MediaQuery.of(context).size.width / 1.8),
    );
  }
}

class ColorAdjustImageCarouselAppBar extends StatefulWidget {
  final Widget Function(Color color)? actionBuilder;
  final List<String> imageUrls;
  final double imageRatio;

  final Widget? child;
  const ColorAdjustImageCarouselAppBar({
    super.key,
    this.actionBuilder,
    required this.imageUrls,
    this.imageRatio = 3 / 4,
    this.child,
  });

  factory ColorAdjustImageCarouselAppBar.loading() {
    return ColorAdjustImageCarouselAppBar(
      imageUrls: const [],
      child:
          TEShimmer.fromSize(width: double.infinity, height: double.infinity),
    );
  }

  @override
  State<ColorAdjustImageCarouselAppBar> createState() =>
      _ColorAdjustImageCarouselAppBarState();
}

class _ColorAdjustImageCarouselAppBarState
    extends State<ColorAdjustImageCarouselAppBar> {
  Color primaryColor = DS.color.background000;
  bool needToBeWhite = true;
  bool isCollapsed = false;

  Future<void> onBackgroundImageUrlChanged(String imageUrl) async {
    if (isCollapsed) return;
    final backgroundColorComputeResult = await calcBackgroundImage(imageUrl);
    if (backgroundColorComputeResult == null) return;
    Future.delayed(Duration.zero, () {
      setState(() {
        if (!mounted || isCollapsed) return;
        primaryColor = backgroundColorComputeResult.backgroundColor;
        needToBeWhite = backgroundColorComputeResult.isNeedToBeWhiteText;
      });
    });
  }

  void changeIsCollapsed(bool isCollapsed) {
    Future.delayed(Duration.zero, () {
      setState(() => this.isCollapsed = isCollapsed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = (width / widget.imageRatio);
    final react = Get.find<IReact>();

    final iconColor = isCollapsed
        ? DS.color.background700
        : (needToBeWhite ? DS.color.background000 : DS.color.background700);

    return SliverAppBar(
      backgroundColor: isCollapsed ? DS.color.background000 : primaryColor,
      surfaceTintColor: isCollapsed ? DS.color.background000 : primaryColor,
      leading: IconButton(
        onPressed: react.back,
        icon: DS.image.leftArrowInBox(color: iconColor),
      ),
      pinned: true,
      actions: widget.actionBuilder == null
          ? null
          : [
              widget.actionBuilder!(iconColor),
              DS.space.hXSmall,
            ],
      toolbarHeight: DS.space.large,
      expandedHeight: height - DS.space.large,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        if (settings != null &&
            constraints.biggest.height < settings.minExtent * 1.5) {
          changeIsCollapsed(true);
        } else {
          changeIsCollapsed(false);
        }

        return widget.child == null
            ? FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: TEImageCarousel(
                  ratio: widget.imageRatio,
                  width: width,
                  imageSrcs: widget.imageUrls,
                  overlayAdditionalHorizontalPadding: 0.0,
                  onNetworkImageChanged: (imageUrl) =>
                      onBackgroundImageUrlChanged(imageUrl),
                ),
              )
            : SizedBox(
                width: width,
                height: height,
                child: widget.child!,
              );
      }),
    );
  }
}
