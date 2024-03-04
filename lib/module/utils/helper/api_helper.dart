import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class Apihelper {
  Apihelper._();
  static final Apihelper apihelper = Apihelper._();
  String? token;
  String? otpnum;

  Future singupapi({
    required String name,
    required String email,
    required String password,
    required String cpassword,
    required String city,
    required String country,
    required String state,
  }) async {
    http.Response response = await http.post(
      Uri.parse("https://uat.redprix.com/api/customers/customers"),
      body: {
        "name": name,
        "email": email,
        "password": password,
        "confirm_password": cpassword,
        "country_id": country,
        "state_id": state,
        "city_id": city,
      },
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 201) {
      var ans = jsonDecode(response.body);
      otpnum = ans["data"]['email_otp'];
      return response.statusCode;
    } else {
      var ans = jsonDecode(response.body);
      var mes = "${ans['message']}";
      print("${response.statusCode}");
      print("${response.body}");
      return mes;
    }
  }

  Future loginapi({required String email, required String password}) async {
    http.Response response = await http.post(
        Uri.parse("https://uat.redprix.com/api/login"),
        body: {"email": email, "password": password});
    if (response.statusCode == 200) {
      Map decodedata = jsonDecode(response.body);
      Map products = decodedata['data'];
      token = products['authorization'];
      return response.statusCode;
    } else {
      var ans = jsonDecode(response.body);
      var mes = "${ans['message']}";
      print("${response.statusCode}");
      return mes;
    }
  }

  Future<List<dynamic>?> getdata() async {
    log("$token");

    http.Response response = await http.get(
      Uri.parse(
        "https://uat.redprix.com/api/customers/posts",
      ),
      headers: {
        "Accept": "application/json",
        "DeviceID": "11111",
        "versionName": "1.0.0",
        "DeviceType": "0",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      var body = response.body;
      Map decodedata = jsonDecode(body);
      List data = decodedata['data'];
      return data;
    } else {
      print("${response.body}");
      log("${response.statusCode}");
      return null;
    }
  }

  Future verifyotp({required String email, required String number}) async {
    http.Response response = await http.post(
        Uri.parse("https://uat.redprix.com/api/verify-email"),
        body: {"email": email, "email_otp": number});
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      log("${response.body}");
      return response.statusCode;
    } else {
      var ans = jsonDecode(response.body);
      var mes = "${ans['message']}";
      print("${response.statusCode}");
      return mes;
    }
  }
}
