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
            leadingIconOnPressed: controller.react.back, title: DS.text.login),
        body: Padding(
          padding: EdgeInsets.all(DS.space.xBase),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TeameatIntroduce(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(DS.text.trySnsJoinOrLogin),
                  DS.space.vSmall,
                  SnsLoginButton(
                    logoImage: DS.image.kakaoLogo,
                    backgroundColor: const Color(0xFFF7E409),
                    text: DS.text.loginWithKakao,
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
            DS.image.mainLargeIconNoBg,
            DS.space.hSmall,
            Text(DS.text.teameatIntroduce1, style: DS.textStyle.title3)
          ],
        ),
        DS.space.vSmall,
        Text(
          DS.text.teameatIntroduce2,
          style: DS.textStyle.paragraph2.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          DS.text.teameatIntroduce3,
          style:
              DS.textStyle.paragraph2.copyWith(color: DS.color.background600),
        ),
        DS.space.vXBase,
        Text(
          DS.text.teameatIntroduce4,
          style: DS.textStyle.paragraph2,
        ),
        DS.space.vXBase,
        Text(DS.text.willYouJoinUs,
            style:
                DS.textStyle.paragraph2.copyWith(fontWeight: FontWeight.bold))
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
        height: DS.space.large,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            borderRadius ?? DS.space.tiny,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoImage,
            DS.space.hXTiny,
            Text(
              text,
              style: DS.textStyle.paragraph3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
