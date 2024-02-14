import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/ingredient.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/screens/cook_env_camera_screen.dart';
import 'package:lookncook/screens/ingredient_preparation_screen/components/ingredient_prep_item.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class IngredientPreparationScreen extends StatefulWidget {
  final Recipe recipe;

  const IngredientPreparationScreen({
    super.key,
    required this.recipe,
  });

  @override
  State<IngredientPreparationScreen> createState() =>
      _IngredientPreparationScreenState();
}

class _IngredientPreparationScreenState
    extends State<IngredientPreparationScreen> {
  final FlutterTts tts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  Future<List<CameraDescription>> cameras = availableCameras();

  bool _speechEnabled = false;
  int idx = 0;

  late Ingredient ingredient;

  Future<void> readIngredient() async {
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    // read possible threats if any

    if (idx == 0) {
      await tts.speak(
          "For the first step, we will take out the ingredients from the refrigerator.");
    }

    await tts.speak(ingredient.locationDescription);
    // TODO(용재): Next 들으면 goNext 호출
    if (!_speechEnabled) {
      _initSpeech();
    }
  }

  @override
  void initState() {
    super.initState();
    ingredient = widget.recipe.ingredients[0];

    readIngredient();
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
    if (result.recognizedWords == "Next") {
      goNext();
    }
    setState(() {});
  }

  void goNext() {
    if (idx == widget.recipe.ingredients.length - 1) {
      // TODO(용재): 조리환경 촬영 스크린으로 넘어가기
      Get.to(() => CookEnvCameraScreen(recipe: widget.recipe));
    } else {
      setState(() {
        idx += 1;
        ingredient = widget.recipe.ingredients[idx];
      });
      readIngredient();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Ingredient Preparation",
        )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Text(
                  "${idx + 1}/${widget.recipe.ingredients.length} Complete",
                  style: context.textTheme.titleMedium
                      ?.apply(color: Theme.of(context).colorScheme.secondary)),
            ),
            IngredientPrepItem(
                ingredient: ingredient,
                onPress: goNext,
                isLast: idx == widget.recipe.ingredients.length - 1),
          ],
        ));
  }
}
