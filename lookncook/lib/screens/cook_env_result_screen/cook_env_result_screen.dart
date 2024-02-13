import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/cook_env_state.dart';
import 'package:lookncook/screens/cook_env_result_screen/components/cook_env_state_item.dart';

class CookEnvResultScreen extends StatefulWidget {
  final List<CookEnvState> cookEnvStateList;
  final String imageUrl;

  const CookEnvResultScreen(
      {super.key, required this.cookEnvStateList, required this.imageUrl});

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

    // TODO(용재): 요리하기 화면으로 넘어가기
    // Get.to(() => CookEnvResultScreen(
    //       cookEnvStateList: dummyCookEnvState,
    //       imageUrl:
    //           'https://www.world-grain.com/ext/resources/2022/10/25/Rice_AdobeStock_64819529_E.jpg?height=667&t=1666706505&width=1080',
    //     ));
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
              child: Image.network(widget.imageUrl),
              fit: BoxFit.fill,
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
