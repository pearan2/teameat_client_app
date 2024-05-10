import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/root_page.dart';
import 'package:teameat/1_presentation/core/root_page_binding.dart';
import 'package:teameat/1_presentation/home/home_page.dart';
import 'package:teameat/1_presentation/home/home_page_binding.dart';

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
    ];
