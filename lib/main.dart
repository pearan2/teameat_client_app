// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teameat/0_config/dependency_config.dart';
import 'package:teameat/0_config/environment.dart';
// import 'package:teameat/0_config/firebase_message_config.dart';
// import 'package:teameat/0_config/firebase_options.dart';
import 'package:teameat/0_config/page_config.dart';
// import 'package:teameat/1_presentation/core/root_page.dart';

Future<void> main() async {
  // 추후 첫 로딩 속도가 너무 느릴 경우 Splash Controller 쪽으로 이동시킬 것
  // V1 단계에서는 FB 가 필요하지 않다.
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await configDependency();
  // await configMessage();
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 이 앱은 portraitUp 으로만 사용할 수 있습니다.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final env = Get.find<Environment>();

    return GetMaterialApp(
      getPages: allPages(),
      initialRoute: "/",
      debugShowCheckedModeBanner: env.isDev,
    );
  }
}
