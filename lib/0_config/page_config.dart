import 'package:get/get.dart';
import 'package:teameat/1_presentation/community/community_page.dart';
import 'package:teameat/1_presentation/community/community_page_binding.dart';
import 'package:teameat/1_presentation/community/create/community_create_page.dart';
import 'package:teameat/1_presentation/community/create/community_create_page_binding.dart';
import 'package:teameat/1_presentation/community/view/community_view_page.dart';
import 'package:teameat/1_presentation/community/view/community_view_page_binding.dart';
import 'package:teameat/1_presentation/core/auth/login_page.dart';
import 'package:teameat/1_presentation/core/auth/login_page_binding.dart';
import 'package:teameat/1_presentation/core/payment/payment_page.dart';
import 'package:teameat/1_presentation/core/payment/payment_page_binding.dart';
import 'package:teameat/1_presentation/core/payment/payment_result_page.dart';
import 'package:teameat/1_presentation/core/payment/payment_result_page_binding.dart';
import 'package:teameat/1_presentation/core/root_page.dart';
import 'package:teameat/1_presentation/core/root_page_binding.dart';
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
import 'package:teameat/1_presentation/user/customer_service_page.dart';
import 'package:teameat/1_presentation/user/customer_service_page_binding.dart';
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
        name: "/community",
        binding: CommunityPageBinding(),
        page: () => const CommunityPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/community/create",
        binding: CommunityCreatePageBinding(),
        page: () => const CommunityCreatePage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/community/view",
        binding: CommunityViewPageBinding(),
        page: () => const CommunityViewPage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/user",
        binding: UserPageBinding(),
        page: () => const UserPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/user/detail",
        binding: UserDetailPageBinding(),
        page: () => const UserDetailPage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/voucher",
        binding: VoucherPageBinding(),
        page: () => const VoucherPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/voucher/detail",
        binding: VoucherDetailPageBinding(),
        page: () => const VoucherDetailPage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/voucher/used",
        binding: VoucherUsedPageBinding(),
        page: () => const VoucherUsedPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: "/store",
        binding: StorePageBinding(),
        page: () => const StorePage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/store/item/purchase",
        binding: PurchasePageBinding(),
        page: () => const PurchasePage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/store/like",
        binding: StoreLikePageBinding(),
        page: () => const StoreLikePage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/store/item/like",
        binding: StoreItemLikePageBinding(),
        page: () => const StoreItemLikePage(),
        transitionDuration: const Duration(milliseconds: 200),
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
      ),
    ];
