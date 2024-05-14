abstract class IRouter {
  void toRoot();

  void toHomeOffAll();

  void toStoreItemDetail(int itemId);

  void back();

  Future<void> toLogin();
}
