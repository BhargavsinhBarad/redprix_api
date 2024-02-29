import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:redprix_api/module/utils/helper/api_helper.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home page"),
      ),
      body: FutureBuilder(
        future: Apihelper.apihelper.getdata(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            List? data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (ctx, i) {
                return Text("${data[i]['description']}");
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
