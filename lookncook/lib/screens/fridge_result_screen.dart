import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lookncook/apis/apis.dart';
import 'dart:async';

import 'package:lookncook/constants/dummy.dart';
import 'package:lookncook/dtos/cook_env_state.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/screens/cook_env_camera_screen.dart';
import 'package:lookncook/screens/recipe_list_screen/recipe_list_screen.dart';

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
  late File imageFile;
  // var ingredients = dummyIngredients;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    imageFile = widget.imageFile;
    // 5초 후에 _updateLoadingState 함수 호출
    Timer(const Duration(seconds: 5), _updateLoadingState);
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
                      "재료목록",
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
                        children: dummyIngredients.map((ingredient) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: Text(
                              "- ${ingredient.name}",
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
                      Get.to(() => RecipeListScreen(
                          recipeList: dummyRecipeList,
                          ingredients: dummyIngredients));

                      // 버튼 클릭 시 동작
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(120, 70)),
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
              ));
  }
}
