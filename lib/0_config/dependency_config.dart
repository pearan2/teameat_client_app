import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/onboarding_page.dart';
import 'package:teameat/1_presentation/core/react.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
import 'package:teameat/2_application/core/location_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/core/code/statistics/i_statistics_repository.dart';
import 'package:teameat/3_domain/core/i_local_repository.dart';
import 'package:teameat/3_domain/core/i_need_action_repository.dart';
import 'package:teameat/3_domain/core/i_widget_view_count_repository.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/curation/i_curation_temp_save_service.dart';
import 'package:teameat/3_domain/event/coupon/i_coupon_repository.dart';
import 'package:teameat/3_domain/file/i_file_service.dart';
import 'package:teameat/3_domain/message/i_message_repository.dart';
import 'package:teameat/3_domain/order/i_order_repository.dart';
import 'package:teameat/3_domain/payment/i_payment_repository.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/user/block/i_user_block_repository.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/report/i_report_repository.dart';
import 'package:teameat/3_domain/voucher/gift/i_gift_repository.dart';
import 'package:teameat/3_domain/voucher/i_voucher_repository.dart';
import 'package:teameat/4_infra/auth/auth_service.dart';
import 'package:teameat/4_infra/connection/connection.dart';
import 'package:teameat/4_infra/core/code/code_repository.dart';
import 'package:teameat/4_infra/core/curation_search_history_repository.dart';
import 'package:teameat/4_infra/core/local_repository.dart';
import 'package:teameat/4_infra/core/need_action_repository.dart';
import 'package:teameat/4_infra/core/statistics/statistics_repository.dart';
import 'package:teameat/4_infra/core/store_item_search_history_repository.dart';
import 'package:teameat/4_infra/core/widget_view_count_repository.dart';
import 'package:teameat/4_infra/curation/curation_repository.dart';
import 'package:teameat/4_infra/curation/curation_temp_save_service.dart';
import 'package:teameat/4_infra/event/coupon/coupon_repository.dart';
import 'package:teameat/4_infra/file/file_service.dart';
import 'package:teameat/4_infra/message/message_repository.dart';
import 'package:teameat/4_infra/order/order_repository.dart';
import 'package:teameat/4_infra/payment/payment_repository.dart';
import 'package:teameat/4_infra/store/item/item_repository.dart';
import 'package:teameat/4_infra/store/store_repository.dart';
import 'package:teameat/4_infra/user/block/user_block_repository.dart';
import 'package:teameat/4_infra/user/report/user_report_repository.dart';
import 'package:teameat/4_infra/user/user_repository.dart';
import 'package:teameat/4_infra/voucher/gift/gift_repository.dart';
import 'package:teameat/4_infra/voucher/voucher_repository.dart';

Future<void> configDependency() async {
  final env = Environment();
  // design system
  DS.init();

  Get.put<Environment>(Environment());
  Get.put<SharedPreferences>(await SharedPreferences.getInstance());

  // repos
  Get.put<IConnection>(HttpClient(endPoint: env.apiEndPoint));
  Get.put<ICodeRepository>(CodeRepository());
  Get.put<IMessageRepository>(MessageRepository());
  Get.put<IStoreRepository>(StoreRepository());
  Get.put<IStoreItemRepository>(StoreItemRepository());
  Get.put<IOrderRepository>(OrderRepository());
  Get.put<IVoucherRepository>(VoucherRepository());
  Get.put<IPaymentRepository>(PaymentRepository());
  Get.put<IGiftRepository>(GiftRepository());
  Get.put<IUserRepository>(UserRepository());
  Get.put<ILocalRepository>(LocalRepository());
  Get.put<ICurationRepository>(CurationRepository());
  Get.put<IUserBlockRepository>(UserBlockRepository());
  Get.put<IReportRepository>(UserReportRepository());
  Get.put<ICouponRepository>(CouponRepository());
  Get.put<IStatisticsRepository>(StatisticsRepository());
  Get.put<CurationSearchHistoryRepository>(CurationSearchHistoryRepository());
  Get.put<StoreItemSearchHistoryRepository>(StoreItemSearchHistoryRepository());

  // service
  Get.put<IAuthService>(AuthService());
  Get.put<IFileService>(FileService());
  Get.put<ICurationTempSaveService>(CurationTempSaveService());

  // global controller
  Get.put<IReact>(React());
  Get.put<LoadingProvider>(LoadingProvider());
  Get.put<LikeController<IStoreItemRepository>>(
      LikeController<IStoreItemRepository>()..load());
  Get.put<LikeController<IStoreRepository>>(
      LikeController<IStoreRepository>()..load());
  Get.put<LikeController<ICurationRepository>>(
      LikeController<ICurationRepository>()..load());
  Get.put<LocationController>(LocationController());

  Get.put<IWidgetViewCountRepository<OnboardingPage>>(
      WidgetViewCountRepository<OnboardingPage>());
  Get.put<INeedActionRepository>(NeedActionRepository());
}
