import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:redprix_api/module/utils/helper/api_helper.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool pass = true;
  String? email;
  String? password;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
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
                          onChanged: (val) {
                            email = val;
                          },
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
                          onChanged: (val) {
                            password = val;
                          },
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
                            hintText: "Enetr password",
                            border: OutlineInputBorder(),
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
                          var res = await Apihelper.apihelper
                              .loginapi(email: email!, password: password!);

                          if (res == 200) {
                            Get.toNamed("/home");
                            Get.snackbar("Login", "successfully");
                            Fluttertoast.showToast(
                              msg: "Login",
                            );
                          } else {
                            Get.snackbar("Login", "failed");
                            Fluttertoast.showToast(
                              msg: "Login failed",
                            );
                            log("$res");
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
                                Get.toNamed("/");
                              },
                              child: const Text("Sign up",
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
                      )
                    ],
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
