import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/i_react.dart';

class OnboardingPage extends StatefulWidget {
  final String lastButtonText;
  final bool enableBack;

  const OnboardingPage(
      {super.key, required this.lastButtonText, this.enableBack = false});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  static const tabLength = 3;
  late final tabController = TabController(length: tabLength, vsync: this);

  bool isFirst = true;
  bool isLast = false;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget _getGuideImage(String path, double topPadding) {
    return Column(
      children: [
        SizedBox(height: topPadding),
        Image.asset(path, fit: BoxFit.fitWidth),
      ],
    );
  }

  void changeState(int nextIdx) {
    final isFirst = nextIdx == 0;
    final isLast = nextIdx == (tabLength - 1);

    setState(() {
      this.isFirst = isFirst;
      this.isLast = isLast;
    });
  }

  String getButtonText() {
    if (isLast) {
      return widget.lastButtonText;
    } else {
      return DS.text.next;
    }
  }

  void onBack() {
    if (isFirst) return;
    final nextIdx = tabController.index - 1;
    changeState(nextIdx);
    tabController.index = nextIdx;
  }

  void onTap() {
    if (isLast) {
      if (widget.enableBack) {
        return Get.back();
      } else {
        return Get.find<IReact>().toHomeOffAll();
      }
    }
    final nextIdx = tabController.index + 1;
    changeState(nextIdx);
    tabController.index = nextIdx;
  }

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(
        withLeading: !isFirst,
        leadingIconOnPressed:
            isFirst ? (widget.enableBack ? Get.back : null) : onBack,
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _getGuideImage('assets/image/onboarding/app_onboarding_1.png',
                      DS.space.base),
                  _getGuideImage('assets/image/onboarding/app_onboarding_2.png',
                      DS.space.xTiny),
                  _getGuideImage('assets/image/onboarding/app_onboarding_3.png',
                      DS.space.base),
                ]),
          ),
          DS.space.vMedium,
          TEPrimaryButton(
            text: getButtonText(),
            onTap: onTap,
            borderRadius: DS.space.tiny,
          ).paddingSymmetric(horizontal: DS.space.xBase),
          DS.space.vBig,
          DS.space.vBase,
        ],
      ),
    );
  }
}
