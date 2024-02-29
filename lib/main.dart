import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redprix_api/module/views/home/views/home.dart';
import 'package:redprix_api/module/views/login/views/login.dart';
import 'package:redprix_api/module/views/otp_page/views/otp.dart';
import 'package:redprix_api/module/views/sing_up/views/sinup.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
          page: () => home(),
        ),
      ],
    ),
  );
}
