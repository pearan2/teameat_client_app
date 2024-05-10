import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/2_application/core/page_controller.dart';

class HomePageController extends PageController {
  final PagingController<int, int> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> loadItem(int currentPageKey) async {
    await Future.delayed(const Duration(seconds: 2));
    pagingController.appendPage(
        List.generate(10, (index) => index + currentPageKey),
        currentPageKey + 10);
  }

  @override
  Future<bool> initialLoad() async {
    pagingController.addPageRequestListener(loadItem);
    return true;
  }
}
