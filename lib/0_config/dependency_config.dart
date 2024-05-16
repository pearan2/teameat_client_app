import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/react.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/message/i_message_repository.dart';
import 'package:teameat/3_domain/order/i_order_repository.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/4_infra/auth/auth_service.dart';
import 'package:teameat/4_infra/connection/connection.dart';
import 'package:teameat/4_infra/core/code/code_repository.dart';
import 'package:teameat/4_infra/message/message_repository.dart';
import 'package:teameat/4_infra/order/order_repository.dart';
import 'package:teameat/4_infra/store/item/item_repository.dart';
import 'package:teameat/4_infra/store/store_repository.dart';

Future<void> configDependency() async {
  final env = Environment();
  Get.put<Environment>(Environment());
  Get.put<SharedPreferences>(await SharedPreferences.getInstance());

  // repos
  Get.put<IConnection>(HttpClient(endPoint: env.apiEndPoint));
  Get.put<ICodeRepository>(CodeRepository());
  Get.put<IMessageRepository>(MessageRepository());
  Get.put<IStoreRepository>(StoreRepository());
  Get.put<IStoreItemRepository>(StoreItemRepository());
  Get.put<IOrderRepository>(OrderRepository());

  // service
  Get.put<IAuthService>(AuthService());

  // global controller
  Get.put<IReact>(React());
  Get.put<LoadingProvider>(LoadingProvider());
}
