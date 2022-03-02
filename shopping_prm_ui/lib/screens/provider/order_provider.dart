import 'package:flutter/cupertino.dart';
import 'package:shopping_prm_ui/screens/model/orders_attr.dart';

class OrdersProvider with ChangeNotifier {
  List<OrdersAttr> _orders = [];
  List<OrdersAttr> get getOrders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    notifyListeners();
  }
}
