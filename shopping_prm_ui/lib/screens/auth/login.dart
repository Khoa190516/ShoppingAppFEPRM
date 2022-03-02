// ignore_for_file: implementation_imports, prefer_final_fields, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/src/feather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_prm_ui/api_serivce.dart';
import 'package:shopping_prm_ui/screens/const/colors.dart';
import 'package:shopping_prm_ui/screens/model/user.dart';
import 'package:shopping_prm_ui/widget/main_screen.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:http/http.dart' as http;
import 'forgetpassword.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  var _emailAddress = TextEditingController();
  var _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> Login() async {
    ApiService apiService = ApiService();
    if (_emailAddress.text.isNotEmpty && _password.text.isNotEmpty) {
      String url = apiService.baseAPI +
          apiService.userAPI +
          _emailAddress.text +
          "/" +
          _password.text;

      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonUser = json.decode(response.body);
        User user = User.fromJson(jsonUser);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool result = await prefs.setString('user', jsonEncode(jsonUser));
        Route route = MaterialPageRoute(builder: (context) => MainScreens());
        Navigator.push(context, route);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid email or password")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Blank Field Not Allowed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [ColorsConsts.gradiendFStart, ColorsConsts.gradiendLStart],
                    [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: const MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: const Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://thumbs.dreamstime.com/b/online-shopping-website-laptop-screen-female-hands-holding-coffee-51467105.jpg',
                      ),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: _emailAddress,
                            key: const ValueKey('email'),
                            validator: (value) {
                              if (value == null || value.isEmpty //||
                                  /*value.contains('@')*/) {
                                return 'Please enter a valid email address';
                              }
                              //return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: const Icon(Icons.email),
                                labelText: 'Email Address',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: _password,
                            key: const ValueKey('Password'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Password';
                              }
                              //return null;
                            },
                            keyboardType: TextInputType.text,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: const Icon(Icons.lock),
                                //suffixIcon: GestureDetector(
                                //  onTap: () {
                                //    setState(() {
                                //      _obscureText = !_obscureText;
                                //    });
                                //  },
                                //  child: Icon(_obscureText
                                //      ? Icons.visibility
                                //      : Icons.visibility_off),
                                //),
                                labelText: 'Password',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {},
                            obscureText: _obscureText,
                            //onEditingComplete: Login,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ForgetPassword.routeName);
                                },
                                child: Text(
                                  'Forget password?',
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      decoration: TextDecoration.underline),
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 10),
                            _isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color:
                                                ColorsConsts.backgroundColor),
                                      ),
                                    )),
                                    onPressed: () {
                                      Login();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Feather.user,
                                          size: 18,
                                        )
                                      ],
                                    )),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
