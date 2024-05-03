import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/react.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
import 'package:teameat/3_domain/message/i_message_repository.dart';
import 'package:teameat/4_infra/connection/connection.dart';
import 'package:teameat/4_infra/message/message_repository.dart';

Future<void> configDependency() async {
  final env = Environment();
  Get.put<Environment>(Environment());
  Get.put<SharedPreferences>(await SharedPreferences.getInstance());

  // repos
  Get.put<HttpClient>(HttpClient(endPoint: env.apiEndPoint));
  Get.put<IMessageRepository>(MessageRepository());

  // global controller
  Get.put<IReact>(React());
  Get.put<LoadingProvider>(LoadingProvider());
}
