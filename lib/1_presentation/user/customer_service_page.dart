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
          title: DS.getText().customerQuestion,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: DS.getColor().background300,
                  ),
                  DS.getSpace().vMedium,
                  Text(
                    DS.getText().customerServiceTitle,
                    style: DS.getTextStyle().paragraph1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  DS.getSpace().vBase,
                  Text(
                    DS.getText().customerServiceContent,
                    style: DS.getTextStyle().paragraph3,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                DS.getImage().customerService,
                DS.getSpace().vTiny,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DS.getText().customerServiceOperationTime,
                      style: DS
                          .getTextStyle()
                          .paragraph3
                          .copyWith(color: DS.getColor().background600),
                    ),
                    DS.getSpace().hXBase,
                  ],
                ),
                DS.getSpace().vTiny,
                SnsLoginButton(
                  logoImage: DS.getImage().kakaoLogo,
                  backgroundColor: const Color(0xFFF7E409),
                  text: DS.getText().customerServiceKakaoQuestion,
                  onTap: controller.onCustomerServiceClickHandler,
                  borderRadius: 0.0,
                ),
              ],
            )
          ],
        ));
  }
}
