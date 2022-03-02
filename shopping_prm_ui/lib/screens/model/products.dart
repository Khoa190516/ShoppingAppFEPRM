// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_prm_ui/screens/model/product.dart';
import 'package:http/http.dart' as http;
import '../../api_serivce.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products {
    return [..._products];
  }

  Products() {
    FetchProducts();
    //_products = getProducts();
  }

  List<Product> parseProduct(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    var products = list.map((model) => Product.fromJson(model)).toList();
    return products;
  }

  Future<void> FetchProducts() async {
    ApiService apiService = ApiService();
    String url = apiService.baseAPI + apiService.productAPI;

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _products = parseProduct(response.body.toString());
      notifyListeners();
    }

    //   Product(
    //       "Hanes Mens",
    //       "Long Sleeve Beefy Henley Shirt",
    //       "Hanes Men's Long Sleeve Beefy Henley Shirt",
    //       22.30,
    //       'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
    //       'Clothes',
    //       'No brand',
    //       58466,
    //       false,
    //       true),
    //   Product(
    //       "Weave Jogger",
    //       "Weave Jogger",
    //       "Champion Mens Reverse Weave Jogger",
    //       50.30,
    //       'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
    //       'Clothes',
    //       'H&M',
    //       58466,
    //       false,
    //       true),
    //   Product(
    //       "Adeliber Dresses for Womens",
    //       "Adeliber Dresses for Womens",
    //       "Adeliber Dresses for Womens, Sexy Solid Sequined Stitching Shining Club Sheath Long Sleeved Mini Dress",
    //       99.30,
    //       'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
    //       'Clothes',
    //       'Adidas',
    //       1616,
    //       false,
    //       true),
    //   Product(
    //       "Hanes Mens",
    //       "Long Sleeve Beefy Henley Shirt",
    //       "Hanes Men's Long Sleeve Beefy Henley Shirt",
    //       22.30,
    //       'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
    //       'Clothes',
    //       'Hogwart',
    //       2233,
    //       false,
    //       true)
    // ];
  }

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular).toList();
  }

  List<Product> get favsProducts {
    return _products.where((element) => element.isFavorite).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product> findByCategory(String categoryName) {
    List<Product> _categoryList = _products
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();

    return _categoryList;
  }

  List<Product> findByBrand(String brandName) {
    List<Product> _categoryList = _products
        .where((element) =>
            element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> searchQuery(String searchText) {
    List<Product> _searchList = _products
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
}
