import 'package:flutter/cupertino.dart';
import 'package:shopping_prm_ui/screens/model/cart_product_attr.dart';

class CartProductProvider with ChangeNotifier {
  List<CartProductAttr> _cartproducts = [];
  List<CartProductAttr> get getOrders {
    return [..._cartproducts];
  }

  Future<void> fetchOrders() async {
    // fetch Orders
    notifyListeners();
  }
}
