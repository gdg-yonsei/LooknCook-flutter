import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/cook_env_state.dart';
import 'package:lookncook/dtos/enums.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/dtos/recipe_step.dart';
import 'package:lookncook/screens/cook_env_result_screen/components/cook_env_state_item.dart';
import 'package:lookncook/screens/cook_finish_screen.dart';
import 'package:lookncook/screens/cooking_screen/components/recipe_step_item.dart';

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
  int stepIdx = 0;

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
      step.threat.forEach((e) async {
        await tts.speak("${threatContent[e]}");
        // TODO(용재): Done 이라고 말하는거 기다리기
      });
    }

    tts.speak(step.body);
  }

  @override
  void initState() {
    super.initState();
    step = widget.recipe.steps[0];

    readStep();
  }

  // TODO(용재): 항상 Next 라고 말하는거 기다리다가 잡히면 goNextStep 호출

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