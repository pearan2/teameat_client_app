import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/auth/login_page.dart';
import 'package:teameat/1_presentation/core/auth/login_page_binding.dart';
import 'package:teameat/1_presentation/core/payment/payment_page.dart';
import 'package:teameat/1_presentation/core/payment/payment_page_binding.dart';
import 'package:teameat/1_presentation/core/root_page.dart';
import 'package:teameat/1_presentation/core/root_page_binding.dart';
import 'package:teameat/1_presentation/home/home_page.dart';
import 'package:teameat/1_presentation/home/home_page_binding.dart';
import 'package:teameat/1_presentation/store/item/purchase_page.dart';
import 'package:teameat/1_presentation/store/item/purchase_page_binding.dart';
import 'package:teameat/1_presentation/store/item/store_item_page.dart';
import 'package:teameat/1_presentation/store/item/store_item_page_binding.dart';

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
        name: "/store/item",
        binding: StoreItemPageBinding(),
        page: () => const StoreItemPage(),
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
        name: "/payment",
        binding: PaymentPageBinding(),
        page: () => const PaymentPage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: "/login",
        binding: LoginPageBinding(),
        page: () => const LoginPage(),
        transition: Transition.noTransition,
      ),
    ];
