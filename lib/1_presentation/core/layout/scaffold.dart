import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';

class TEScaffold extends StatelessWidget {
  static const iosBottomPadding = 24.0;
  static const androidBottomPadding = 0.0;

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;
  final Color? bottomSheetBackgroundColor;
  final BottomNavigatorType? activated;
  final bool loading;
  final String? loadingText;
  final void Function(bool didPop)? onPop;
  final void Function()? onFloatingButtonClick;
  final Widget? floatingButtonIcon;
  final bool resizeToAvoidBottomInset;
  final Widget? bottomFloatingButton;
  const TEScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
    this.activated,
    this.bottomSheetBackgroundColor,
    this.loadingText,
    this.loading = false,
    this.onPop,
    this.onFloatingButtonClick,
    this.floatingButtonIcon,
    this.bottomFloatingButton,
    this.resizeToAvoidBottomInset = false,
  });

  Widget _buildChild() {
    if (activated != null) {
      return Column(
        children: [
          Expanded(
            child: _InnerScaffold(
              key: key,
              body: body,
              appBar: appBar,
              bottomSheet: bottomSheet,
              bottomSheetBackgroundColor: bottomSheetBackgroundColor,
              onFloatingButtonClick: onFloatingButtonClick,
              floatingButtonIcon: floatingButtonIcon,
              bottomFloatingButton: bottomFloatingButton,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            ),
          ),
          _TEBottomNavigator(
            key: key,
            activated: activated!,
          ),
        ],
      );
    } else {
      return _InnerScaffold(
        key: key,
        body: body,
        appBar: appBar,
        bottomSheet: bottomSheet,
        bottomSheetBackgroundColor: bottomSheetBackgroundColor,
        onFloatingButtonClick: onFloatingButtonClick,
        floatingButtonIcon: floatingButtonIcon,
        bottomFloatingButton: bottomFloatingButton,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: onPop == null,
      onPopInvoked: onPop,
      child: Stack(
        children: [
          _buildChild(),
          Visibility(
            visible: loading,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: DS.color.background800.withOpacity(0.7),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  loadingText == null
                      ? const SizedBox()
                      : DefaultTextStyle(
                          style: const TextStyle(),
                          child: Text(
                            loadingText!,
                            textAlign: TextAlign.center,
                            style: DS.textStyle.paragraph3.copyWith(
                              color: DS.color.background000,
                            ),
                          ),
                        ),
                  loadingText == null ? const SizedBox() : DS.space.vSmall,
                  TELoading(
                    size: DS.space.large,
                  ),
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}

class _InnerScaffold extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;
  final Color? bottomSheetBackgroundColor;
  final void Function()? onFloatingButtonClick;
  final Widget? floatingButtonIcon;
  final bool resizeToAvoidBottomInset;
  final Widget? bottomFloatingButton;

  const _InnerScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
    this.bottomSheetBackgroundColor,
    this.onFloatingButtonClick,
    this.floatingButtonIcon,
    this.bottomFloatingButton,
    required this.resizeToAvoidBottomInset,
  });

  @override
  State<_InnerScaffold> createState() => _InnerScaffoldState();
}

class _InnerScaffoldState extends State<_InnerScaffold> {
  bool visible = true;

  Widget _buildFloatingButton() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      opacity: visible ? 1 : 0,
      child: TEonTap(
        onTap: () {
          if (!visible) return;
          widget.onFloatingButtonClick?.call();
        },
        child: Container(
          width: DS.space.large,
          height: DS.space.large,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: DS.color.primary600,
            borderRadius: const BorderRadius.all(Radius.circular(300)),
          ),
          child: widget.floatingButtonIcon ??
              Icon(
                Icons.keyboard_arrow_up,
                size: DS.space.medium,
                color: DS.color.background000,
              ),
        ),
      ),
    );
  }

  Widget _body() {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final direction = notification.direction;
        if (direction == ScrollDirection.forward) {
          setState(() => visible = true);
        } else if (direction == ScrollDirection.reverse) {
          setState(() => visible = false);
        }
        return true;
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: (GetPlatform.isIOS && widget.bottomSheet != null)
                    ? TEScaffold.iosBottomPadding
                    : TEScaffold.androidBottomPadding),
            child: widget.body,
          ),
          widget.bottomFloatingButton == null
              ? const SizedBox()
              : Positioned(
                  left: 0,
                  right: 0,
                  bottom: GetPlatform.isIOS
                      ? TEScaffold.iosBottomPadding
                      : TEScaffold.androidBottomPadding,
                  child: widget.bottomFloatingButton!,
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      floatingActionButton:
          widget.onFloatingButtonClick != null ? _buildFloatingButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButtonAnimator: null,
      appBar: widget.appBar,
      backgroundColor: DS.color.background000,
      body: widget.resizeToAvoidBottomInset
          ? SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: _body(),
            )
          : _body(),
      bottomSheet: Container(
        color: widget.bottomSheetBackgroundColor,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: GetPlatform.isIOS
                  ? TEScaffold.iosBottomPadding
                  : TEScaffold.androidBottomPadding),
          child: widget.bottomSheet,
        ),
      ),
    );
  }
}

extension BottomNavigatorTypeExtension on BottomNavigatorType {
  Widget getIconClicked() {
    switch (this) {
      case BottomNavigatorType.home:
        return DS.image.bottomIconHomeClicked;
      case BottomNavigatorType.inventory:
        return DS.image.bottomIconVoucherClicked;
      case BottomNavigatorType.community:
        return DS.image.bottomIconCommunityClicked;
      case BottomNavigatorType.profile:
        return DS.image.bottomIconUserClicked;
      default:
        throw 'invalid value';
    }
  }

  Widget getIcon() {
    switch (this) {
      case BottomNavigatorType.home:
        return DS.image.bottomIconHome;
      case BottomNavigatorType.inventory:
        return DS.image.bottomIconVoucher;
      case BottomNavigatorType.community:
        return DS.image.bottomIconCommunity;
      case BottomNavigatorType.profile:
        return DS.image.bottomIconUser;
      default:
        throw 'invalid value';
    }
  }

  Text getTextClicked() {
    return getText(color: DS.color.primary600);
  }

  Text getText({Color? color}) {
    switch (this) {
      case BottomNavigatorType.home:
        return Text(
          DS.text.home,
          style: DS.textStyle.caption2
              .copyWith(color: color ?? DS.color.background500),
        );
      case BottomNavigatorType.inventory:
        return Text(
          DS.text.inventory,
          style: DS.textStyle.caption2
              .copyWith(color: color ?? DS.color.background500),
        );
      case BottomNavigatorType.community:
        return Text(
          DS.text.curation,
          style: DS.textStyle.caption2
              .copyWith(color: color ?? DS.color.background500),
        );
      case BottomNavigatorType.profile:
        return Text(
          DS.text.profile,
          style: DS.textStyle.caption2
              .copyWith(color: color ?? DS.color.background500),
        );
      default:
        throw 'invalid value';
    }
  }
}

enum BottomNavigatorType { home, inventory, community, profile }

class _BottomNavigatorToggle extends StatelessWidget {
  final bool clicked;
  final BottomNavigatorType type;

  const _BottomNavigatorToggle({required this.type, required this.clicked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DS.space.xBase * 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          clicked ? type.getIconClicked() : type.getIcon(),
          DS.space.vXTiny,
          clicked ? type.getTextClicked() : type.getText(),
        ],
      ),
    );
  }
}

class _TEBottomNavigator extends StatelessWidget {
  final BottomNavigatorType activated;
  const _TEBottomNavigator({super.key, required this.activated});

  @override
  Widget build(BuildContext context) {
    final react = Get.find<IReact>();

    return DefaultTextStyle(
      style: const TextStyle(),
      child: Container(
        height: DS.space.large +
            (GetPlatform.isIOS
                ? TEScaffold.iosBottomPadding
                : TEScaffold.androidBottomPadding),
        padding: EdgeInsets.only(
            bottom: GetPlatform.isIOS
                ? TEScaffold.iosBottomPadding
                : TEScaffold.androidBottomPadding),
        decoration: BoxDecoration(
          color: DS.color.background000,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TEonTap(
              onTap: () {
                if (activated != BottomNavigatorType.home) {
                  react.toHomeOffAll();
                }
              },
              child: _BottomNavigatorToggle(
                clicked: activated == BottomNavigatorType.home,
                type: BottomNavigatorType.home,
              ),
            ),
            TEonTap(
              onTap: () {
                if (activated != BottomNavigatorType.community) {
                  react.toCurationOffAll();
                }
              },
              child: _BottomNavigatorToggle(
                clicked: activated == BottomNavigatorType.community,
                type: BottomNavigatorType.community,
              ),
            ),
            TEonTap(
              onTap: () {
                if (activated != BottomNavigatorType.inventory) {
                  react.toVoucherOffAll();
                }
              },
              isLoginRequired: true,
              child: _BottomNavigatorToggle(
                clicked: activated == BottomNavigatorType.inventory,
                type: BottomNavigatorType.inventory,
              ),
            ),
            TEonTap(
              onTap: () {
                if (activated != BottomNavigatorType.profile) {
                  react.toUserOffAll();
                }
              },
              child: _BottomNavigatorToggle(
                clicked: activated == BottomNavigatorType.profile,
                type: BottomNavigatorType.profile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
