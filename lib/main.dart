import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:get/get.dart';
import 'package:statusbarz/statusbarz.dart';
import 'package:teameat/0_config/dependency_config.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/0_config/firebase_options.dart';
import 'package:teameat/0_config/page_config.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/99_util/firebase_cloud_message.dart';

Future<void> main() async {
  // 추후 첫 로딩 속도가 너무 느릴 경우 Splash Controller 쪽으로 이동시킬 것
  // V1 단계에서는 FB 가 필요하지 않다.
  WidgetsFlutterBinding.ensureInitialized();

  /////////////////////

  await NaverMapSdk.instance
      .initialize(clientId: "m6rvxbcwsx", onAuthFailed: print);
  // m6rvxbcwsx

  // firebase cloud message
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MessageHelper.startConsumeInitialMessage();

  initializeDateFormatting();
  await configDependency();

  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  static const horizontalPadding = 16.0;
  static const itemHorizontalSpace = 8.0;

  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 이 앱은 portraitUp 으로만 사용할 수 있습니다.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final env = Get.find<Environment>();

    return StatusbarzCapturer(
      child: TEonTap(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetMaterialApp(
          navigatorObservers: [Statusbarz.instance.observer],
          getPages: allPages(),
          initialRoute: "/",
          debugShowCheckedModeBanner: env.isDev,
          builder: (_, child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
              child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: child!,
              ),
            );
          },
          theme: ThemeData(
            colorScheme: ColorScheme.light(primary: DS.color.primary600),
            useMaterial3: true,
            scaffoldBackgroundColor: DS.color.background000,
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: DS.color.background000,
              surfaceTintColor: DS.color.background000,
            ),
          ),
        ),
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
