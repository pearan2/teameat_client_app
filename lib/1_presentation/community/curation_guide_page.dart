import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';

class CurationRewardGuidePage extends StatelessWidget {
  const CurationRewardGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(
        leadingIconOnPressed: Get.back,
        title: DS.text.reward,
      ),
      body: const _TabView(),
    );
  }
}

class _TabView extends StatefulWidget {
  const _TabView();

  @override
  State<_TabView> createState() => _TabViewState();
}

class _TabViewState extends State<_TabView> with TickerProviderStateMixin {
  static const tabLength = 3;
  late final tabController = TabController(
    length: tabLength,
    vsync: this,
  );

  int nowIdx = 0;

  void tabListener() {
    setState(() => nowIdx = tabController.index);
  }

  @override
  void initState() {
    tabController.addListener(tabListener);
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    tabController.dispose();
    super.dispose();
  }

  Widget _buildController() {
    if (nowIdx == tabLength - 1) {
      return TEPrimaryButton(onTap: Get.back, text: '푸드로그 구경하기')
          .paddingOnly(bottom: 90, left: 20, right: 20);
    }
    return AnimatedSmoothIndicator(
      activeIndex: nowIdx,
      effect: ExpandingDotsEffect(
        dotWidth: DS.space.tiny,
        dotHeight: DS.space.tiny,
        spacing: DS.space.xTiny,
        dotColor: DS.color.background200,
        activeDotColor: DS.color.primary700,
      ),
      duration: const Duration(milliseconds: 200),
      count: tabLength,
    ).paddingOnly(bottom: 130);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              Column(
                children: [
                  DS.space.vMedium,
                  Image.asset(
                      'assets/image/curation/curation_reward_onboarding_1.png'),
                ],
              ),
              Column(
                children: [
                  DS.space.vMedium,
                  Image.asset(
                      'assets/image/curation/curation_reward_onboarding_2.png'),
                ],
              ),
              Center(
                child: Image.asset(
                        'assets/image/curation/curation_reward_onboarding_3.png')
                    .paddingSymmetric(horizontal: DS.space.medium),
              ),
            ],
          ),
        ),
        _buildController(),
      ],
    );
  }
}
