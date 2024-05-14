import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/auth/login_page.dart';
import 'package:teameat/1_presentation/core/auth/login_page_binding.dart';
import 'package:teameat/1_presentation/core/root_page.dart';
import 'package:teameat/1_presentation/core/root_page_binding.dart';
import 'package:teameat/1_presentation/home/home_page.dart';
import 'package:teameat/1_presentation/home/home_page_binding.dart';
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
        name: "/login",
        binding: LoginPageBinding(),
        page: () => const LoginPage(),
        transitionDuration: const Duration(milliseconds: 200),
        transition: Transition.rightToLeft,
      ),
    ];
