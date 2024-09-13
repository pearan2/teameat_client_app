import 'package:get/get.dart';
import 'package:teameat/1_presentation/community/curation_page.dart';
import 'package:teameat/1_presentation/community/curation_page_binding.dart';
import 'package:teameat/1_presentation/community/view/curation_detail_view_page.dart';
import 'package:teameat/1_presentation/community/view/curation_detail_view_page_binding.dart';
import 'package:teameat/1_presentation/community/view/curator_summary_view_page.dart';
import 'package:teameat/1_presentation/community/view/curator_summary_view_page_binding.dart';
import 'package:teameat/1_presentation/store/item/store_item_page.dart';
import 'package:teameat/1_presentation/store/item/store_item_page_binding.dart';
import 'package:teameat/1_presentation/user/block/block_page.dart';
import 'package:teameat/1_presentation/user/block/block_page_binding.dart';
import 'package:teameat/1_presentation/community/create/curation_create_page.dart';
import 'package:teameat/1_presentation/community/create/curation_create_page_binding.dart';
import 'package:teameat/1_presentation/community/view/my_curation_detail_view_page.dart';
import 'package:teameat/1_presentation/community/view/my_curation_detail_view_page_binding.dart';
import 'package:teameat/1_presentation/core/auth/login_page.dart';
import 'package:teameat/1_presentation/core/auth/login_page_binding.dart';
import 'package:teameat/1_presentation/core/payment/payment_page.dart';
import 'package:teameat/1_presentation/core/payment/payment_page_binding.dart';
import 'package:teameat/1_presentation/core/payment/payment_result_page.dart';
import 'package:teameat/1_presentation/core/payment/payment_result_page_binding.dart';
import 'package:teameat/1_presentation/core/root_page.dart';
import 'package:teameat/1_presentation/core/root_page_binding.dart';
import 'package:teameat/1_presentation/gift/gift_create_page.dart';
import 'package:teameat/1_presentation/gift/gift_create_page_binding.dart';
import 'package:teameat/1_presentation/gift/gift_page.dart';
import 'package:teameat/1_presentation/gift/gift_page_binding.dart';
import 'package:teameat/1_presentation/gift/gift_receive_page.dart';
import 'package:teameat/1_presentation/gift/gift_receive_page_binding.dart';
import 'package:teameat/1_presentation/gift/gift_success_page.dart';
import 'package:teameat/1_presentation/gift/gift_success_page_binding.dart';
import 'package:teameat/1_presentation/home/home_page.dart';
import 'package:teameat/1_presentation/home/home_page_binding.dart';
import 'package:teameat/1_presentation/store/item/like_page.dart';
import 'package:teameat/1_presentation/store/item/like_page_binding.dart';
import 'package:teameat/1_presentation/store/item/purchase_page.dart';
import 'package:teameat/1_presentation/store/item/purchase_page_binding.dart';
import 'package:teameat/1_presentation/store/like_page.dart';
import 'package:teameat/1_presentation/store/like_page_binding.dart';
import 'package:teameat/1_presentation/store/store_page.dart';
import 'package:teameat/1_presentation/store/store_page_binding.dart';
import 'package:teameat/1_presentation/user/curation/user_curation_page.dart';
import 'package:teameat/1_presentation/user/curation/user_curation_page_binding.dart';
import 'package:teameat/1_presentation/user/customer_service_page.dart';
import 'package:teameat/1_presentation/user/customer_service_page_binding.dart';
import 'package:teameat/1_presentation/user/follow/user_follower_page.dart';
import 'package:teameat/1_presentation/user/follow/user_follower_page_binding.dart';
import 'package:teameat/1_presentation/user/user_detail_page.dart';
import 'package:teameat/1_presentation/user/user_detail_page_binding.dart';
import 'package:teameat/1_presentation/user/user_page.dart';
import 'package:teameat/1_presentation/user/user_page_binding.dart';
import 'package:teameat/1_presentation/voucher/voucher_detail_page.dart';
import 'package:teameat/1_presentation/voucher/voucher_detail_page_binding.dart';
import 'package:teameat/1_presentation/voucher/voucher_page.dart';
import 'package:teameat/1_presentation/voucher/voucher_page_binding.dart';
import 'package:teameat/1_presentation/voucher/voucher_used_page.dart';
import 'package:teameat/1_presentation/voucher/voucher_used_page_binding.dart';

const transitionDuration = Duration(milliseconds: 250);

List<GetPage> allPages() => [
      GetPage(
        name: "/",
        binding: RootPageBinding(),
        page: () => const RootPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/home",
        binding: HomePageBinding(),
        page: () => const HomePage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/curation",
        binding: CurationPageBinding(),
        page: () => const CurationPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/curation/detail/:curationId",
        binding: CurationDetailViewPageBinding(),
        page: () => CurationDetailViewPage(Get.parameters['curationId']!),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/curation/create",
        binding: CurationCreatePageBinding(),
        page: () => const CurationCreatePage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/curation/curator/summary",
        binding: CuratorSummaryViewPageBinding(),
        page: () => const CuratorSummaryViewPage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/user",
        binding: UserPageBinding(),
        page: () => const UserPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/user/block",
        binding: UserBlockPageBinding(),
        page: () => const UserBlockPage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/user/follower",
        binding: UserFollowerPageBinding(),
        page: () => const UserFollowerPage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/user/curation",
        binding: UserCurationPageBinding(),
        page: () => const UserCurationPage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/user/curation/view",
        binding: MyCurationDetailViewPageBinding(),
        page: () => const MyCurationDetailViewPage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/gift",
        binding: GiftPageBinding(),
        page: () => const GiftPage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/user/detail",
        binding: UserDetailPageBinding(),
        page: () => const UserDetailPage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/voucher",
        binding: VoucherPageBinding(),
        page: () => const VoucherPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/voucher/detail/:voucherId",
        binding: VoucherDetailPageBinding(),
        page: () => const VoucherDetailPage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/voucher/used",
        binding: VoucherUsedPageBinding(),
        page: () => const VoucherUsedPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/voucher/gift",
        binding: GiftCreatePageBinding(),
        page: () => const GiftCreatePage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/voucher/gift/success",
        binding: GiftSuccessPageBinding(),
        page: () => const GiftSuccessPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/voucher/gift/receive",
        binding: GiftReceivePageBinding(),
        page: () => const GiftReceivePage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/store",
        binding: StorePageBinding(),
        page: () => const StorePage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/store/item/detail/:itemId",
        binding: StoreItemPageBinding(),
        page: () => StoreItemPage(Get.parameters['itemId']!),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/store/item/purchase",
        binding: PurchasePageBinding(),
        page: () => const PurchasePage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/store/like",
        binding: StoreLikePageBinding(),
        page: () => const StoreLikePage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/store/item/like",
        binding: StoreItemLikePageBinding(),
        page: () => const StoreItemLikePage(),
        transitionDuration: transitionDuration,
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/payment",
        binding: PaymentPageBinding(),
        page: () => const PaymentPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/payment/result",
        binding: PaymentResultPageBinding(),
        page: () => const PaymentResultPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/login",
        binding: LoginPageBinding(),
        page: () => const LoginPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/customer-service",
        binding: CustomerServicePageBinding(),
        page: () => const CustomerServicePage(),
        transition: Transition.noTransition,
        transitionDuration: Duration.zero,
      ),
    ];
