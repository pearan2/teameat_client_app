import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class PageController extends GetxController {
  final react = Get.find<IReact>();

  Future<bool> initialLoad() async => true;

  @override
  Future<void> onInit() async {
    super.onInit();
    react.isPageLoading = true;
    final initLoadingResult = await initialLoad();
    react.isPageLoading = false;
    if (!initLoadingResult) showError(DS.text.initPageFail);
  }

  Future<void> resolve<T>(
    Future<Either<Failure, T>> future,
    void Function(T r) rightCallback,
  ) async {
    react.isEventLoading = true;
    final ret = await future;
    react.isEventLoading = false;
    ret.fold((l) => showError(l.desc), (r) => rightCallback(r));
  }
}
