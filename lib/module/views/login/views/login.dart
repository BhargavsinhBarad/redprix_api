import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:redprix_api/module/utils/helper/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

final _formKey = GlobalKey<FormState>();

class _loginState extends State<login> {
  bool showSpinner = false;
  bool pass = true;
  String? email;
  String? password;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
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
                  "https://img.freepik.com/free-photo/medium-shot-man-taking-selfie-with-food_23-2149155170.jpg",
                ),
                fit: BoxFit.cover,
              ),
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
                    "Sign up",
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 180,
                            child: Image.network(
                                "https://img.freepik.com/free-vector/sign-concept-illustration_114360-125.jpg"),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter email..";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              email = val;
                            },
                            controller: emailcontroller,
                            decoration: const InputDecoration(
                              hintText: "Enter email id ",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Password",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter password..";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              password = val;
                            },
                            controller: passwordcontroller,
                            obscureText: pass,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    pass = !pass;
                                  });
                                },
                                icon: (pass == true)
                                    ? const Icon(Icons.remove_red_eye_sharp)
                                    : const Icon(Icons.remove_red_eye_outlined),
                              ),
                              hintText: "Enter password",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                showSpinner = true;
                              });
                              var res = await Apihelper.apihelper
                                  .loginapi(email: email!, password: password!);
                              if (res == 200) {
                                setState(() {
                                  showSpinner = false;
                                });
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setBool("login", true);
                                Get.offAllNamed("/home");
                                Fluttertoast.showToast(
                                  msg: "Login",
                                );
                                emailcontroller.clear();
                                passwordcontroller.clear();
                              } else {
                                setState(() {
                                  showSpinner = false;
                                });
                                Fluttertoast.showToast(
                                  msg: res,
                                );
                                log("$res");
                              }
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
                            child: Center(
                              child: (showSpinner == true)
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
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
                                  Get.toNamed("/");
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/google.jpg"),
                            ),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/facebook.png"),
                            ),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/apple.png"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
