// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopping_prm_ui/bottom_bar.dart';
import 'package:shopping_prm_ui/screens/home.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), Home()],
    );
  }
}
