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
  final String imageUrl;

  const CookEnvResultScreen(
      {super.key,
      required this.cookEnvStateList,
      required this.imageUrl,
      required this.recipe});

  @override
  State<CookEnvResultScreen> createState() => _CookEnvResultScreenState();
}

class _CookEnvResultScreenState extends State<CookEnvResultScreen> {
  final FlutterTts tts = FlutterTts();
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
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(widget.imageUrl),
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
