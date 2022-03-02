// ignore_for_file: prefer_final_fields, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_prm_ui/screens/auth/login.dart';
import 'package:shopping_prm_ui/screens/cart/cart.dart';
import 'package:shopping_prm_ui/screens/provider/dark_theme.dart';
import 'package:shopping_prm_ui/screens/wishlist/wishlist.dart';

import 'const/colors.dart';
import 'const/my_icons.dart';
import 'model/user.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _scrollController = ScrollController();
  var top = 0.0;
  String _uid = "";
  String _name = "Khoa";
  String _email = "";
  String _joinedAt = "";
  String _phoneNumber = '0123456789';
  String _userImageUrl = "";
  User user = new User();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json = jsonDecode(pref.getString('user').toString());
    user = User.fromJson(json);
    print(user.email.toString());

    setState(() {
      _name = user.name.toString().toLowerCase();
      _email = user.email.toString();
      _joinedAt = user.joinedAt.toString();
      _phoneNumber = user.phoneNumber.toString();
      _userImageUrl = user.userImageUrl.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            ColorsConsts.starterColor,
                            ColorsConsts.endColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'http://cdn.onlinewebfonts.com/svg/img_264157.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  // 'top.toString()',
                                  _name = user.name.toString().toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      background: Image(
                        image: NetworkImage(
                            'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=900.0&fit=crop'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Bag')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(WishlistScreen.routeName);
                          },
                          title: Text('Wishlist'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          leading: Icon(MyAppIcons.wishlist),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
                          },
                          title: Text('Cart'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          leading: Icon(MyAppIcons.cart),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(onTap: () {
                          //do sth here
                        }),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(onTap: () {
                          //do sth here
                        }),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Information')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('Email', _email, 0, context),
                    userListTile('Phone number', _phoneNumber, 1, context),
                    userListTile('Shipping address', '', 2, context),
                    userListTile('joined date', _joinedAt, 3, context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle('User settings'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    // ListTileSwitch(
                    //   value: false,
                    //   leading: Icon(Ionicons.md_moon),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       false;
                    //     });
                    //   },
                    //   visualDensity: VisualDensity.comfortable,
                    //   switchType: SwitchType.cupertino,
                    //   switchActiveColor: Colors.indigo,
                    //   title: Text('Dark theme'),
                    // ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () async {
                            // Navigator.canPop(context)? Navigator.pop(context):null;
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6.0),
                                          child: Image.network(
                                            'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=900.0&fit=crop',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Sign out'),
                                        ),
                                      ],
                                    ),
                                    content: Text('Do you wanna Sign out?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Route route = MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen());
                                            Navigator.push(context, route);
                                          },
                                          child: Text(
                                            'Ok',
                                            style: TextStyle(color: Colors.red),
                                          ))
                                    ],
                                  );
                                });
                          },
                          title: Text('Logout'),
                          leading: Icon(Icons.exit_to_app_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          _buildFab()
        ],
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(_userTileIcons[index]),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
