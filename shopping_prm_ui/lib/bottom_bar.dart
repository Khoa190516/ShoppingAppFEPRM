// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, unused_field, unnecessary_const, sized_box_for_whitespace, prefer_collection_literals, unnecessary_new

import 'package:flutter/material.dart';
import 'package:shopping_prm_ui/screens/cart/cart.dart';
import 'package:shopping_prm_ui/screens/const/my_icons.dart';
import 'package:shopping_prm_ui/screens/feeds.dart';
import 'package:shopping_prm_ui/screens/home.dart';
import 'package:shopping_prm_ui/screens/user.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Map<String, Widget>> _pages = [
    {
      'page': Home(),
    },
    {
      'page': Feeds(),
    },
    // {
    //   'page': Search(),
    // },
    {
      'page': CartScreen(),
    },
    {
      'page': UserInfo(),
    },
  ];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': Home(),
      },
      {
        'page': Feeds(),
      },
      // {
      //   'page': Search(),
      // },
      {
        'page': CartScreen(),
      },
      {
        'page': UserInfo(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 1.1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.purple,
              currentIndex: _selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(MyAppIcons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(MyAppIcons.rss),
                  title: Text('Feeds'),
                ),
                // const BottomNavigationBarItem(
                //   activeIcon: null,
                //   icon: Icon(null),
                //   title: Text('Search'),
                // ),
                BottomNavigationBarItem(
                  icon: Icon(
                    MyAppIcons.bag,
                  ),
                  title: Text('Cart'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(MyAppIcons.user),
                  title: Text('User'),
                ),
              ],
            ),
          ),
        ),
      ),
      //floatingActionButtonLocation:
      //    FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.purple,
      //     hoverElevation: 10,
      //     splashColor: Colors.grey,
      //     tooltip: 'Search',
      //     elevation: 4,
      //     child: Icon(MyAppIcons.search),
      //     onPressed: () => setState(() {
      //       _selectedPageIndex = 2;
      //     }),
      //   ),
      //),
    );
  }
}
