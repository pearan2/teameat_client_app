import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';

class TEScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;
  final Color? bottomSheetBackgroundColor;
  final BottomNavigatorType? activated;
  final bool loading;
  final void Function(bool didPop)? onPop;
  final void Function()? onFloatingButtonClick;

  const TEScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
    this.activated,
    this.bottomSheetBackgroundColor,
    this.loading = false,
    this.onPop,
    this.onFloatingButtonClick,
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
                  child: TELoading(
                size: DS.space.large,
              )),
            ),
          )
        ],
      ),
    );
  }
}

class _InnerScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;
  final Color? bottomSheetBackgroundColor;
  final void Function()? onFloatingButtonClick;

  const _InnerScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
    this.bottomSheetBackgroundColor,
    this.onFloatingButtonClick,
  });

  Widget _buildFloatingButton() {
    return TEonTap(
      onTap: () => onFloatingButtonClick?.call(),
      child: Container(
        width: DS.space.large,
        height: DS.space.large,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: DS.color.primary500,
          borderRadius: const BorderRadius.all(Radius.circular(300)),
        ),
        child: Icon(
          Icons.keyboard_arrow_up,
          size: DS.space.medium,
          color: DS.color.background000,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          onFloatingButtonClick != null ? _buildFloatingButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: appBar,
      backgroundColor: DS.color.background000,
      body: Padding(
        padding: EdgeInsets.only(
            bottom: (GetPlatform.isIOS && bottomSheet != null)
                ? DS.space.xBase
                : 0.0),
        child: body,
      ),
      bottomSheet: Container(
        color: bottomSheetBackgroundColor,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: GetPlatform.isIOS ? DS.space.xBase : 0.0),
          child: bottomSheet,
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
      case BottomNavigatorType.profile:
        return DS.image.bottomIconUser;
      default:
        throw 'invalid value';
    }
  }

  Text getTextClicked() {
    return getText(color: DS.color.primary500);
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

enum BottomNavigatorType { home, inventory, profile }

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

    return Container(
      height: DS.space.large +
          DS.space.tiny +
          (GetPlatform.isIOS ? DS.space.xBase : 0.0),
      padding:
          EdgeInsets.only(bottom: GetPlatform.isIOS ? DS.space.xBase : 0.0),
      decoration: BoxDecoration(
        color: DS.color.background000,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TEonTap(
            onTap: react.toHomeOffAll,
            child: _BottomNavigatorToggle(
              clicked: activated == BottomNavigatorType.home,
              type: BottomNavigatorType.home,
            ),
          ),
          TEonTap(
            onTap: react.toVoucherOffAll,
            isLoginRequired: true,
            child: _BottomNavigatorToggle(
              clicked: activated == BottomNavigatorType.inventory,
              type: BottomNavigatorType.inventory,
            ),
          ),
          TEonTap(
            onTap: react.toUserOffAll,
            child: _BottomNavigatorToggle(
              clicked: activated == BottomNavigatorType.profile,
              type: BottomNavigatorType.profile,
            ),
          ),
        ],
      ),
    );
  }
}
