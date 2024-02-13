import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lookncook/dtos/ingredient.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/screens/ingredient_preparation_screen/components/ingredient_prep_item.dart';

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
  }

  @override
  void initState() {
    super.initState();
    ingredient = widget.recipe.ingredients[0];

    readIngredient();
  }

  void goNext() {
    if (idx == widget.recipe.ingredients.length - 1) {
      // TODO(용재): 조리환경 촬영 스크린으로 넘어가기
      // Get.to(() => const CookFinishScreen());
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
            IngredientPrepItem(
                ingredient: ingredient,
                onPress: goNext,
                isLast: idx == widget.recipe.ingredients.length - 1)
          ],
        ));
  }
}
