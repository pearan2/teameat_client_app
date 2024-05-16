import 'package:teameat/3_domain/store/item/item.dart';

abstract class IRouter {
  void toRoot();

  void toHomeOffAll();

  void toStoreItemDetail(int itemId);

  void back<T>({T? result});

  Future<void> toLogin();

  void toItemPurchase(Map<ItemDetail, int> items);

  void toPayment();
}
