import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/ingredient.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientItem({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(35 / 2)),
        child: Image.network(ingredient.thumbnailImage,
            width: 40, height: 40, fit: BoxFit.cover),
      ),
      title: Text(
        ingredient.name,
      ),
    );
  }
}
