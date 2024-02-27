import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Apihelper {
  Apihelper._();

  static final Apihelper apihelper = Apihelper._();

  Future<Object> loginapi(
      {required String email, required String password}) async {
    http.Response response = await http.post(
        Uri.parse("https://uat.redprix.com/api/login"),
        body: {"email": email, "password": password});
    if (response.statusCode == 200) {
      print("${response.body}");
      return response.statusCode;
    } else {
      print("${response.statusCode}");
      return response.statusCode;
    }
  }

  Future<Object> singupapi({
    required String name,
    required String email,
    required String password,
    required String cpassword,
    required String country,
    required String state,
    required String city,
  }) async {
    http.Response response = await http
        .post(Uri.parse("https://redprix.com/api/customers/customers"), body: {
      "name": name,
      "email": email,
      "password": password,
      "confirm_password": cpassword,
      "country_id": country,
      "state_id": state,
      "city_id": city,
    });
    if (response.statusCode == 200) {
      print("${response.body}");
      return response.statusCode;
    } else {
      print("${response.statusCode}");
      return response.statusCode;
    }
  }

  Future<List<dynamic>?> getdata() async {
    var ans = await http.get(
        Uri.parse("https://uat.redprix.com/api/customers/posts"),
        headers: {});
    if (ans.statusCode == 200) {
      log("${ans.statusCode}");
      var body = ans.body;
      Map decodedata = jsonDecode(body);
      List products = decodedata['data'];
      return products;
    } else {
      log("${ans.statusCode}");
      return null;
    }
  }
}
