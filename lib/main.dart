import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redprix_api/module/views/home/views/home.dart';
import 'package:redprix_api/module/views/login/views/login.dart';
import 'package:redprix_api/module/views/otp_page/views/otp.dart';
import 'package:redprix_api/module/views/sing_up/views/sinup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool islogin = preferences.getBool("login") ?? false;
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: (islogin) ? '/home' : '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => singup(),
        ),
        GetPage(
          name: '/otp',
          page: () => otp(),
        ),
        GetPage(
          name: '/login',
          page: () => login(),
        ),
        GetPage(
          name: '/home',
          page: () => const home(),
        ),
      ],
    ),
  );
}
