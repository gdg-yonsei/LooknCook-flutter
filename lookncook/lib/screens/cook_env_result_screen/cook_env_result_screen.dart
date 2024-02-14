import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/cook_env_state.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/screens/cook_env_result_screen/components/cook_env_state_item.dart';
import 'package:lookncook/screens/cooking_screen/cooking_screen.dart';

class CookEnvResultScreen extends StatefulWidget {
  final List<CookEnvState> cookEnvStateList;
  final Recipe recipe;
  final File imageFile;

  const CookEnvResultScreen(
      {super.key,
      required this.cookEnvStateList,
      required this.recipe,
      required this.imageFile});

  @override
  State<CookEnvResultScreen> createState() => _CookEnvResultScreenState();
}

class _CookEnvResultScreenState extends State<CookEnvResultScreen> {
  final FlutterTts tts = FlutterTts();
  late File imageFile;

  void speakWithTts() async {
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    await tts.speak(
      widget.cookEnvStateList.map((i) => i.content).join("....."),
    );

    Get.to(() => CookingScreen(
          recipe: widget.recipe,
        ));
  }

  @override
  void initState() {
    super.initState();
    imageFile = widget.imageFile;

    speakWithTts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Cooking Environment",
        )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 400,
              height: 300,
              child: Image.file(
                imageFile,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
                child: ListView(
              children: widget.cookEnvStateList
                  .expand((envState) => <Widget>[
                        CookEnvStateItem(envState: envState),
                        const Divider(
                          height: 0,
                        )
                      ])
                  .toList(),
            )),
          ],
        ));
  }
}
