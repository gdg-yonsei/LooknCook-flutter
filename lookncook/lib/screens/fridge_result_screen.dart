import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lookncook/apis/apis.dart';

class FridgeResultScreen extends StatefulWidget {
  final File imageFile;

  const FridgeResultScreen({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  State<FridgeResultScreen> createState() => _FridgeResultScreenState();
}

class _FridgeResultScreenState extends State<FridgeResultScreen> {
  late Future<dynamic> fetchedData;
  late File imageFile;

  @override
  void initState() {
    super.initState();
    imageFile = widget.imageFile;
    // fetchedData = LCApis().uploadFridge(imageFile);
    fetchedData = LCApis().ping();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: fetchedData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // API에서 뽑아낸 결과로 아래의 List 때리기!..
            // Mock으로 넣어두기
            var ingredients = ["사과", "양배추", "귤", "사골", "육수"];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 400,
                  height: 450,
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "재료목록",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ingredients.map((ingredient) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text(
                            "- $ingredient",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                    // 버튼 클릭 시 동작
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(120, 70)),
                  ),
                  child: const Text(
                    "냉장고 맞춤 레시피 추천받기",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
                const SizedBox(
                  height: 30,
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
