import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  String id = "";
  String title = "";
  String description = "";
  double price = 0.0;
  String imageUrl = "";
  String productCategoryName = "";
  String brand = "";
  int quantity = 0;
  bool isFavorite = false;
  bool isPopular = false;

  Product(
      {this.id = "",
      this.title = "",
      this.description = "",
      this.price = 0,
      this.imageUrl = "",
      this.productCategoryName = "",
      this.brand = "",
      this.quantity = 0,
      this.isFavorite = false,
      this.isPopular = false});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    productCategoryName = json['productCategoryName'];
    brand = json['brand'];
    quantity = json['quantity'];
    isFavorite = json['isFavorite'];
    isPopular = json['isPopular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    data['productCategoryName'] = this.productCategoryName;
    data['brand'] = this.brand;
    data['quantity'] = this.quantity;
    data['isFavorite'] = this.isFavorite;
    data['isPopular'] = this.isPopular;
    return data;
  }
}
