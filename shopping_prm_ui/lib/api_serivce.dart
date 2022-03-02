import 'package:flutter/foundation.dart';

class ApiService with ChangeNotifier {
  final String baseAPI = 'http://120.72.85.201:8001/api/';
  final String userAPI = 'User/';
  final String productAPI = 'Products';

  ApiService() {
    baseAPI;
    userAPI;
    productAPI;
  }
}

class LoginModel {
  String username;
  String password;

  LoginModel({
    this.username = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': username.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
