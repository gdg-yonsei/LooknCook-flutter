import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lookncook/dtos/enums.dart';
import 'package:lookncook/dtos/recipe_step.dart';

class RecipeStepItem extends Card {
  final RecipeStep step;
  final void Function() onPress;
  final bool isLast;

  const RecipeStepItem(
      {super.key,
      required this.step,
      required this.onPress,
      required this.isLast});

  static const Map<CookThreat, String> cookThreatIcons = {
    CookThreat.fire: "🔥",
    CookThreat.knife: "🔪",
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                //
                children: [
                  ...step.threat.isNotEmpty
                      ? [
                          Row(
                            children: [
                              Text("Rist Factors",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              const SizedBox(
                                width: 8,
                              ),
                              ...step.threat
                                  .expand((t) => [
                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          transformAlignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer),
                                          child: Text(
                                            "${cookThreatIcons[t]}",
                                            style:
                                                context.textTheme.titleMedium,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        )
                                      ])
                                  .toList(),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          )
                        ]
                      : [],
                  Text(
                    "${step.index}. ${step.title}",
                    style: context.textTheme.titleLarge?.apply(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeightDelta: 5,
                        fontSizeDelta: 5),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    step.body,
                    style: context.textTheme.titleLarge?.apply(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeightDelta: 1),
                  ),
                ]),
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
