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
  final bool withBottomNavigator;
  final bool loading;

  const TEScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
    this.withBottomNavigator = false,
    this.loading = false,
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildChild(),
        Visibility(
          visible: loading,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: DS.getColor().background800.withOpacity(0.7),
            child: Center(
                child: TELoading(
              size: DS.getSpace().large,
            )),
          ),
        )
      ],
    );
  }
}

class _InnerScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;
  const _InnerScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: DS.getColor().background000,
      body: Padding(
        padding: EdgeInsets.only(
            bottom: GetPlatform.isIOS && bottomSheet != null
                ? DS.getSpace().xBase
                : 0.0),
        child: body,
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
            bottom: GetPlatform.isIOS ? DS.getSpace().xBase : 0.0),
        child: bottomSheet,
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
      height: DS.getSpace().large,
      decoration: BoxDecoration(
        color: DS.getColor().background000,
        boxShadow: [
          BoxShadow(
              color: DS.getColor().background800.withOpacity(0.15),
              spreadRadius: DS.getSpace().xxTiny,
              blurRadius: DS.getSpace().tiny,
              offset: Offset(0, -DS.getSpace().xTiny))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TEonTap(
            onTap: react.toHomeOffAll,
            child: DS.getImage().bottomIconHome,
          ),
          TEonTap(
            onTap: react.toVoucherOffAll,
            isLoginRequired: true,
            child: DS.getImage().bottomIconVoucher,
          ),
          TEonTap(
            onTap: react.toUserOffAll,
            isLoginRequired: true,
            child: DS.getImage().bottomIconUser,
          ),
        ],
      ),
    );
  }
}
