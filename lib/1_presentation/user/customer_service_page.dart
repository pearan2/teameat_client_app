import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/auth/login_page.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/user/customer_service_page_controller.dart';

class CustomerServicePage extends GetView<CustomerServicePageController> {
  const CustomerServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        appBar: TEAppBar(
          leadingIconOnPressed: controller.react.back,
          homeOnPressed: controller.react.toHomeOffAll,
          title: DS.text.customerQuestion,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: DS.color.background300,
                  ),
                  DS.space.vMedium,
                  Text(
                    DS.text.customerServiceTitle,
                    style: DS.textStyle.paragraph1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DS.space.vBase,
                  Text(
                    DS.text.customerServiceContent,
                    style: DS.textStyle.paragraph3,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DS.image.customerService,
                DS.space.vTiny,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DS.text.customerServiceOperationTime,
                      style: DS.textStyle.paragraph3
                          .copyWith(color: DS.color.background600),
                    ),
                    DS.space.hXBase,
                  ],
                ),
                DS.space.vTiny,
                SnsLoginButton(
                  logoImage: DS.image.kakaoLogo,
                  backgroundColor: const Color(0xFFF7E409),
                  text: DS.text.customerServiceKakaoQuestion,
                  onTap: controller.onCustomerServiceClickHandler,
                  borderRadius: 0.0,
                ),
              ],
            )
          ],
        ));
  }
}
