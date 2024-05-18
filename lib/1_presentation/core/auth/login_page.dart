import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/auth/login_page_controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        appBar: TEAppBar(
            leadingIconOnPressed: controller.react.back,
            title: DS.getText().login),
        body: Padding(
          padding: EdgeInsets.all(DS.getSpace().xBase),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TeameatIntroduce(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(DS.getText().trySnsJoinOrLogin),
                  DS.getSpace().vSmall,
                  SnsLoginButton(
                    logoImage: DS.getImage().kakaoLogo,
                    backgroundColor: const Color(0xFFF7E409),
                    text: DS.getText().loginWithKakao,
                    onTap: controller.loginWithKakao,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class TeameatIntroduce extends StatelessWidget {
  const TeameatIntroduce({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DS.getImage().mainLargeIconNoBg,
            DS.getSpace().hSmall,
            Text(DS.getText().teameatIntroduce1,
                style: DS.getTextStyle().title3)
          ],
        ),
        DS.getSpace().vSmall,
        Text(
          DS.getText().teameatIntroduce2,
          style: DS
              .getTextStyle()
              .paragraph2
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          DS.getText().teameatIntroduce3,
          style: DS
              .getTextStyle()
              .paragraph2
              .copyWith(color: DS.getColor().background600),
        ),
        DS.getSpace().vXBase,
        Text(
          DS.getText().teameatIntroduce4,
          style: DS.getTextStyle().paragraph2,
        ),
        DS.getSpace().vXBase,
        Text(DS.getText().willYouJoinUs,
            style: DS
                .getTextStyle()
                .paragraph2
                .copyWith(fontWeight: FontWeight.bold))
      ],
    );
  }
}

class SnsLoginButton extends StatelessWidget {
  final Image logoImage;
  final Color backgroundColor;
  final String text;
  final void Function() onTap;
  final double? borderRadius;

  const SnsLoginButton({
    super.key,
    required this.logoImage,
    required this.backgroundColor,
    required this.text,
    required this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      child: Container(
        height: DS.getSpace().large,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            borderRadius ?? DS.getSpace().tiny,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoImage,
            DS.getSpace().hXTiny,
            Text(
              text,
              style: DS.getTextStyle().paragraph3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
