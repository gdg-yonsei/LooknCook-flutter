import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/ingredient.dart';

class IngredientPrepItem extends Card {
  final Ingredient ingredient;
  final void Function() onPress;
  final bool isLast;

  const IngredientPrepItem(
      {super.key,
      required this.ingredient,
      required this.onPress,
      required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(ingredient.thumbnailImage)
                                .image)),
                    height: 250),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  ingredient.name,
                  style: context.theme.textTheme.titleLarge?.apply(
                      color: Theme.of(context).primaryColor,
                      fontWeightDelta: 2,
                      fontSizeDelta: 5),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  ingredient.locationDescription,
                  style: context.theme.textTheme.titleMedium
                      ?.apply(fontSizeDelta: 3),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () {
                onPress();
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  isLast ? "Done" : "Next",
                  style:
                      context.textTheme.titleLarge?.apply(fontWeightDelta: 2),
                  // style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
