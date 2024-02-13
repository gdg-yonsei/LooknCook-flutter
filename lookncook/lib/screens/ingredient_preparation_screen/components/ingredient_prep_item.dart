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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: Image.network(ingredient.thumbnailImage).image,
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    Text(
                      ingredient.name,
                      style: context.textTheme.titleLarge?.apply(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeightDelta: 5,
                          fontSizeDelta: 5),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      ingredient.locationDescription,
                      style: context.textTheme.titleLarge?.apply(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeightDelta: 1),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
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
            )
          ],
        ),
      ),
    );
  }
}
