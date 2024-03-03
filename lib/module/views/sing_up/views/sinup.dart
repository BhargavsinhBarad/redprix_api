import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:redprix_api/module/utils/helper/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:redprix_api/module/views/sing_up/model/signupmodel.dart';

class singup extends StatefulWidget {
  singup({super.key});

  @override
  State<singup> createState() => _singupState();
}

class _singupState extends State<singup> {
  String? name;
  String? email;
  String? password;
  String? cpassword;
  static TextEditingController namecon = TextEditingController();
  static TextEditingController emailcon = TextEditingController();
  static TextEditingController passcon = TextEditingController();
  static TextEditingController cpasscon = TextEditingController();

  static String? city;
  static String? state;
  static String? country;

  bool pass = true;
  bool cpass = true;

  List countrylist = ["101"];

  List statelist = ["12"];

  List citylist = ["1041"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height * 0.3,
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://img.freepik.com/free-photo/medium-shot-man-taking-selfie-with-food_23-2149155170.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Welcome to Redprix",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Sign up to connect to with our app",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: Get.height * 0.75,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Full Name",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            onChanged: (val) {
                              name = val;
                            },
                            controller: namecon,
                            decoration: const InputDecoration(
                              hintText: "Enter your name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Email Id",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            onChanged: (val) {
                              email = val;
                            },
                            controller: emailcon,
                            decoration: const InputDecoration(
                              hintText: "Enter email id ",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Text("Country",
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(
                                width: 60,
                              ),
                              Text("State",
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(
                                width: 75,
                              ),
                              Text("City",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              DropdownMenu<String>(
                                initialSelection: null,
                                onSelected: (String? value) {
                                  setState(() {
                                    country = value!;
                                  });
                                },
                                width: Get.width * 0.3,
                                dropdownMenuEntries: countrylist
                                    .map<DropdownMenuEntry<String>>((value) {
                                  return DropdownMenuEntry(
                                      value: value, label: value);
                                }).toList(),
                              ),
                              DropdownMenu<String>(
                                initialSelection: null,
                                onSelected: (String? value) {
                                  setState(() {
                                    state = value!;
                                  });
                                },
                                width: Get.width * 0.298,
                                dropdownMenuEntries: statelist
                                    .map<DropdownMenuEntry<String>>((value) {
                                  return DropdownMenuEntry(
                                      value: value, label: value);
                                }).toList(),
                              ),
                              DropdownMenu<String>(
                                initialSelection: null,
                                onSelected: (String? value) {
                                  setState(() {
                                    city = value!;
                                  });
                                },
                                width: Get.width * 0.29,
                                dropdownMenuEntries: citylist
                                    .map<DropdownMenuEntry<String>>((value) {
                                  return DropdownMenuEntry(
                                      value: value, label: value);
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Set Password",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            onChanged: (val) {
                              password = val;
                            },
                            controller: passcon,
                            obscureText: pass,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    pass = !pass;
                                  });

                                  log("$pass");
                                },
                                icon: (pass == true)
                                    ? Icon(Icons.remove_red_eye_sharp)
                                    : Icon(Icons.remove_red_eye_outlined),
                              ),
                              hintText: "Enetr password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Confirm Password",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            onChanged: (val) {
                              cpassword = val;
                            },
                            obscureText: cpass,
                            controller: cpasscon,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    cpass = !cpass;
                                  });
                                },
                                icon: (cpass == true)
                                    ? const Icon(Icons.remove_red_eye_sharp)
                                    : const Icon(Icons.remove_red_eye_outlined),
                              ),
                              hintText: "Confirm password",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (password == cpassword) {
                              var res = await Apihelper.apihelper.singupapi(
                                name: name!,
                                email: email!,
                                password: password!,
                                cpassword: cpassword!,
                                country: country!,
                                state: state!,
                                city: city!,
                              );
                              log("${res}");
                              if (res == 201) {
                                Get.toNamed('/home');
                                Get.snackbar("signup", "successfully");
                                Fluttertoast.showToast(
                                  msg: "Login",
                                );
                              } else {
                                Get.snackbar("signup", "failed",
                                    backgroundColor: Colors.red);
                                Fluttertoast.showToast(
                                  msg: "login failed",
                                );
                              }
                            } else {
                              Get.snackbar("password", "enter valid passwrd",
                                  backgroundColor: Colors.red);
                              Fluttertoast.showToast(
                                msg: "Enter valid password.",
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                                child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already member?",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed("/login");
                                },
                                child: const Text("Login",
                                    style: TextStyle(color: Colors.blue)),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/google.jpg"),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/facebook.png"),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/apple.png"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
