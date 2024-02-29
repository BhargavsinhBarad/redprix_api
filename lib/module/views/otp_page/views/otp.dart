import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redprix_api/module/utils/helper/api_helper.dart';

class otp extends StatelessWidget {
  otp({super.key});

  String? num;
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
                    "Verify",
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
                        color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Verify to email with our app",
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
                    children: [
                      Center(
                        child: Container(
                          height: 250,
                          child: Image.network(
                              "https://cdni.iconscout.com/illustration/premium/thumb/otp-security-4120631-3427365.png"),
                        ),
                      ),
                      Text(
                        "Verify Email",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          onChanged: (val) {
                            num = val;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter OTP",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            "Resend",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var res = await Apihelper.apihelper.verifyotp(
                              email: "dilipsinh@gmail.com", number: num!);
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
                            "Confirm",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
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
