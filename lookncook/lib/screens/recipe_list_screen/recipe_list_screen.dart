import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/components/ingredient_item.dart';
import 'package:lookncook/dtos/ingredient.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/screens/ingredient_preparation_screen/ingredient_preparation_screen.dart';
import 'package:lookncook/screens/recipe_list_screen/components/recipe_item.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RecipeListScreen extends StatefulWidget {
  final List<Recipe> recipeList;
  final List<Ingredient> ingredients;

  const RecipeListScreen(
      {super.key, required this.recipeList, required this.ingredients});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final FlutterTts tts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    tts.speak(
        "With the ingredients in your refrigerator, you can make dishes such as ${widget.recipeList.sublist(0, 2).map((i) => i.name).join(",")}${widget.ingredients.length > 2 ? ", and more!" : "!"} Please select or say the name of the recipe, and I’ll assist you further.");
    tts.setCompletionHandler(() {
      if (!_speechEnabled) {
        _initSpeech();
      }
    });
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    _startListening();
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
    // 원하는 음식을 말하면 넘어가도록!
    if (result.recognizedWords == "ABC") {
      Recipe recipe =
          widget.recipeList.firstWhere((recipe) => recipe.name == "ABC");
      Get.to(() => IngredientPreparationScreen(recipe: recipe));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "My Ingredients",
                style: context.textTheme.headlineMedium,
              ),
            ),
            Expanded(
                child: ListView(
              children: widget.ingredients
                  .expand((ingredient) => <Widget>[
                        IngredientItem(ingredient: ingredient),
                        const Divider(
                          height: 0,
                        )
                      ])
                  .toList(),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "Custom Recipe List",
                style: context.textTheme.headlineMedium,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: widget.recipeList.map((recipe) {
                  return GestureDetector(
                    onTap: () {
                      // 탭된 RecipeItem과 관련된 스크린으로 이동하는 로직을 구현
                      Get.to(() => IngredientPreparationScreen(recipe: recipe));
                    },
                    child: RecipeItem(recipe: recipe),
                  );
                }).toList(),
              ),
            )),
          ],
        ));
  }
}
