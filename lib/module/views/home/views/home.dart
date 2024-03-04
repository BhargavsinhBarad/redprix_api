import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redprix_api/module/utils/helper/api_helper.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        height: 40,
                        width: 40,
                        child: const Image(
                          image: AssetImage("assets/glass.png"),
                          fit: BoxFit.cover,
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
                                  CircleAvatar(
                                    radius: 25,
                                    foregroundImage: NetworkImage(
                                        "${data[i]['user']['profile_photo']}"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${data[i]['user']['name']}"),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.watch_later_outlined,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "45 min",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            "Surat city",
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                child: Image.network(
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
