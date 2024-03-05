import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:redprix_api/module/utils/helper/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * 0.18,
            width: Get.width,
            color: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 21,
                        foregroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSGNOdbeaGTYnc3fUN2gAi_H6g4Mx4OtHWu9hvAIQeZ3sA0SeRfDMvgaD79qH0gyZOtRA&usqp=CAU"),
                      ),
                      SizedBox(
                        width: Get.width * 0.22,
                      ),
                      const Text(
                        "Foodfie Zone",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Image.asset("assets/icons8-bell-24.png"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          width: Get.width * 0.5,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Searching...",
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          var res = await Apihelper.apihelper.logoutapi();
                          Fluttertoast.showToast(
                            msg: res['message'],
                          );
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setBool("login", false);
                          Get.toNamed("/");
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Apihelper.apihelper.getdata(),
              builder: (ctx, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  List? data = snapshot.data;
                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 4),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: (data[i]['user']
                                                        ['profile_photo'] ==
                                                    "")
                                                ? const NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4mYGiDHOtUVcSxuzNfeds4xWXNOpQ-lIMPA&usqp=CAU",
                                                  )
                                                : NetworkImage(
                                                    "${data[i]['user']['profile_photo']}",
                                                  ),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${data[i]['user']['name']}"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.watch_later_outlined,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text(
                                            "45 min",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          (data[i]['city']['name'] == null)
                                              ? const Text(
                                                  "Surat",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                )
                                              : Text(
                                                  "${data[i]['city']['name']}",
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Image(
                                      image: AssetImage("assets/dot.png"),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: Get.height * 0.35,
                                width: Get.width,
                                child: (data[i]['images'][0]['image'] == "")
                                    ? Image.network(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkg3xIvd5F5PdBNHq02XJTO4I35KlUDiyA2A&usqp=CAU")
                                    : Image.network(
                                        "${data[i]['images'][0]['image']}",
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Get.height,
                                child: Text(
                                  "${data[i]['description']}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.thumb_up,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "${data[i]['likes_count']} Likes",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.15,
                                  ),
                                  const Icon(
                                    Icons.comment_outlined,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "${data[i]['comments_count']} Comments",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.ios_share_sharp,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "${data[i]['shares_count']}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
