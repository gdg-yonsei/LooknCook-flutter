import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/enums.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/dtos/recipe_step.dart';
import 'package:lookncook/screens/cook_finish_screen.dart';
import 'package:lookncook/screens/cooking_screen/components/recipe_step_item.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CookingScreen extends StatefulWidget {
  final Recipe recipe;

  const CookingScreen({
    super.key,
    required this.recipe,
  });

  @override
  State<CookingScreen> createState() => _CookingScreenState();
}

class _CookingScreenState extends State<CookingScreen> {
  final FlutterTts tts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();

  int stepIdx = 0;
  bool _speechEnabled = false;

  late RecipeStep step;

  static const Map<CookThreat, String> threatContent = {
    CookThreat.fire:
        "This is the stage of using fire. Place the pot in the fire pit and say 'Done'.",
    CookThreat.knife:
        "This is the stage that you need to use a knife. Please put on your gloves and say 'Done'.",
  };

  Future<void> readStep() async {
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    // read possible threats if any
    if (step.threat.isNotEmpty) {
      tts.speak(["${threatContent[step.threat[0]]}", step.body].join(" "));
      //   step.threat.forEach((e) async {

      //     // TODO(용재): Done 이라고 말하는거 기다리기
      //     // if (!_speechEnabled) {
      //     //   _initSpeech();
      //     // }
      //   });
      // }
    } else {
      tts.speak([step.body].join(" "));
    }
    // TODO(용재): 항상 Next 라고 말하는거 기다리다가 잡히면 goNextStep 호출
    // if (!_speechEnabled) {
    //   _initSpeech();
    // }
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    await Future.delayed(const Duration(seconds: 5), () => _startListening());
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 10),
      localeId: "en_En",
    );
    setState(() {});
  }

  Future<void> _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.recognizedWords == "Next" || result.recognizedWords == "Done") {
      goNextStep();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    step = widget.recipe.steps[0];

    readStep();
  }

  void goNextStep() {
    if (stepIdx == widget.recipe.steps.length - 1) {
      Get.to(() => const CookFinishScreen());
    } else {
      setState(() {
        stepIdx += 1;
        step = widget.recipe.steps[stepIdx];
      });
      readStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Cooking",
        )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecipeStepItem(
                step: step,
                onPress: goNextStep,
                isLast: stepIdx == widget.recipe.steps.length - 1)
          ],
        ));
  }
}
