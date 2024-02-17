import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/route_manager.dart';
import 'package:lookncook/components/ingredient_item.dart';
import 'package:lookncook/dtos/ingredient.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/screens/recipe_list_screen/recipe_list_screen.dart';

class FridgeResultScreen extends StatefulWidget {
  final File imageFile;
  final List<Ingredient> ingredients;
  final List<Recipe> recipeList;

  const FridgeResultScreen(
      {Key? key,
      required this.imageFile,
      required this.ingredients,
      required this.recipeList})
      : super(key: key);

  @override
  State<FridgeResultScreen> createState() => _FridgeResultScreenState();
}

class _FridgeResultScreenState extends State<FridgeResultScreen> {
  late File imageFile;
  bool _isLoading = true;
  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    imageFile = widget.imageFile;
    // 5초 후에 _updateLoadingState 함수 호출
    Timer(const Duration(seconds: 2), () {
      _updateLoadingState();
      tts.speak(
          "There are ingredients such as ${widget.ingredients.sublist(0, 2).map((i) => i.name).join(",")}${widget.ingredients.length > 2 ? ", and more" : ""} in the refrigerator. To receive personalized recipe recommendations, please press the button on the bottom center or say “Show me recipes”. ");
    });
  }

  void _updateLoadingState() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                      "List of Ingredients",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.ingredients.map((ingredient) {
                          return IngredientItem(ingredient: ingredient);
                        }).toList(),
                      ),
                    ),
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => RecipeListScreen(
                          recipeList: widget.recipeList,
                          ingredients: widget.ingredients));

                      // 버튼 클릭 시 동작
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(120, 70)),
                    ),
                    child: const Text(
                      "Get personalized recipes for the refrigerator",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ));
  }
}
