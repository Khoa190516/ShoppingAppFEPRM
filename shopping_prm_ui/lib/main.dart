import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopping_prm_ui/screens/auth/forgetpassword.dart';
import 'package:shopping_prm_ui/screens/auth/login.dart';
import 'package:shopping_prm_ui/screens/cart/cart.dart';
import 'package:shopping_prm_ui/screens/const/colors.dart';
import 'package:shopping_prm_ui/screens/feeds.dart';
import 'package:shopping_prm_ui/screens/inner_screens/brands_navigation_rail.dart';
import 'package:shopping_prm_ui/screens/inner_screens/categories_feeds.dart';
import 'package:shopping_prm_ui/screens/inner_screens/product_details.dart';
import 'package:shopping_prm_ui/screens/wishlist/wishlist.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:provider/provider.dart';

import 'bottom_bar.dart';
import 'screens/const/theme_data.dart';
import 'screens/model/products.dart';
import 'screens/provider/cart_provider.dart';
import 'screens/provider/cartproduct_provider.dart';
import 'screens/provider/dark_theme.dart';
import 'screens/provider/favs_provider.dart';
import 'screens/provider/order_provider.dart';
import 'widget/upload_product_form.dart';

void main() {
  //HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Shop',
        home: LoginScreen(),
        //initialRoute: '/',
        routes: {
          //   '/': (ctx) => LandingPage(),
          BrandNavigationRailScreen.routeName: (ctx) =>
              BrandNavigationRailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          Feeds.routeName: (ctx) => Feeds(),
          WishlistScreen.routeName: (ctx) => WishlistScreen(),
          ProductDetails.routeName: (ctx) => ProductDetails(),
          CategoriesFeedsScreen.routeName: (ctx) => CategoriesFeedsScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          //SignUpScreen.routeName: (ctx) => SignUpScreen(),
          BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
          UploadProductForm.routeName: (ctx) => UploadProductForm(),

          //OrderScreen.routeName: (ctx) => OrderScreen(),
          //CartProductScreen.routeName: (ctx) => CartProductScreen(),
          ForgetPassword.routeName: (ctx) => ForgetPassword(),
        },
      ),
    );
  }
}
