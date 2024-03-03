import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Apihelper {
  Apihelper._();
  static final Apihelper apihelper = Apihelper._();
  String? token;

  Future singupapi({
    required String name,
    required String email,
    required String password,
    required String cpassword,
    required String city,
    required String country,
    required String state,
  }) async {
    Map<String, dynamic> body = {
      "name": "bhargav",
      "email": "bhargavsinhbarad324@gmail.com",
      "password": "1234568",
      "confirm_password": "1234568",
      "country_id": "101",
      "state_id": "12",
      "city_id": "1041",
    };

    http.Response response = await http.post(
      Uri.parse("https://uat.redprix.com/api/customers/customers"),
      body: {
        "name": "bhargav",
        "email": "bhargavsinhbarad324@gmail.com",
        "password": "1234568",
        "confirm_password": "1234568",
        "country_id": "101",
        "state_id": "12",
        "city_id": "1041",
      },
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 201) {
      print("${response.body}");
      return response.statusCode;
    } else {
      print("${response.statusCode}");
      return response.statusCode;
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
      print("=============$token===========");
      return response.statusCode;
    } else {
      print("${response.statusCode}");
      return response.statusCode;
    }
  }

  Future<List<dynamic>?> getdata() async {
    log("+-+-+-+-+-+-$token");
    var ans = await http.get(
      Uri.parse(
        "https://uat.redprix.com/api/customers/posts",
      ),
      headers: {
        "Accept": "application/json",
        // "DeviceID": "11111",
        // "versionName": "1.0.0",
        // "DeviceType": "0",
        'Authorization': 'Bearer $token;',
      },
    );
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

  Future verifyotp({required String email, required String number}) async {
    http.Response response = await http.post(
        Uri.parse("https://uat.redprix.com/api/verify-email"),
        body: {"email": email, "email_otp": number});
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      return response.statusCode;
    } else {
      print("${response.statusCode}");
      return response.statusCode;
    }
  }
}
