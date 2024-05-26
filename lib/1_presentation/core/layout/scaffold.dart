import 'package:flutter/material.dart';
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
  final bool withBottomNavigator;
  final bool loading;
  final void Function(bool didPop)? onPop;

  const TEScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
    this.withBottomNavigator = false,
    this.bottomSheetBackgroundColor,
    this.loading = false,
    this.onPop,
  });

  Widget _buildChild() {
    if (withBottomNavigator) {
      return Column(
        children: [
          Expanded(
            child: _InnerScaffold(
              key: key,
              body: body,
              appBar: appBar,
              bottomSheet: bottomSheet,
              bottomSheetBackgroundColor: bottomSheetBackgroundColor,
            ),
          ),
          _TEBottomNavigator(key: key),
        ],
      );
    } else {
      return _InnerScaffold(
        key: key,
        body: body,
        appBar: appBar,
        bottomSheet: bottomSheet,
        bottomSheetBackgroundColor: bottomSheetBackgroundColor,
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
  const _InnerScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
    this.bottomSheetBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: DS.color.background000,
      body: Padding(
        padding: EdgeInsets.only(
            bottom: (GetPlatform.isIOS &&
                    bottomSheet !=
                        null) // ios 면서, bottomSheet 이 없다면 xBase 만큼 띄워줌
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

class _TEBottomNavigator extends StatelessWidget {
  const _TEBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final react = Get.find<IReact>();

    return Container(
      height: DS.space.large + (GetPlatform.isIOS ? DS.space.xBase : 0.0),
      padding:
          EdgeInsets.only(bottom: GetPlatform.isIOS ? DS.space.xBase : 0.0),
      decoration: BoxDecoration(
        color: DS.color.background000,
        boxShadow: [
          BoxShadow(
              color: DS.color.background800.withOpacity(0.15),
              spreadRadius: DS.space.xxTiny,
              blurRadius: DS.space.tiny,
              offset: Offset(0, -DS.space.xTiny))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TEonTap(
            onTap: react.toHomeOffAll,
            child: DS.image.bottomIconHome,
          ),
          TEonTap(
            onTap: react.toVoucherOffAll,
            isLoginRequired: true,
            child: DS.image.bottomIconVoucher,
          ),
          TEonTap(
            onTap: react.toUserOffAll,
            child: DS.image.bottomIconUser,
          ),
        ],
      ),
    );
  }
}
