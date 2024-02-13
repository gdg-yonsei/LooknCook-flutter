import 'package:flutter/material.dart';
import 'package:lookncook/dtos/enums.dart';
import 'package:lookncook/dtos/recipe.dart';

class RecipeItem extends Card {
  final Recipe recipe;

  const RecipeItem({
    super.key,
    required this.recipe,
  });

  static const Map<RecipeLevel, String> recipeLevelLabels = {
    RecipeLevel.easy: "Easy",
    RecipeLevel.hard: "Hard",
    RecipeLevel.medium: "Medium"
  };

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      isThreeLine: true,
      titleAlignment: ListTileTitleAlignment.threeLine,
      leading: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(35 / 2)),
        child: Image.network(recipe.thumbnailImage,
            width: 35, height: 35, fit: BoxFit.cover),
      ),
      subtitle: Text("Difficulty: ${recipeLevelLabels[recipe.level]}"),
      title: Text(recipe.name),
      trailing: Text(
        "Recommendations\n${recipe.likeCount}",
        textAlign: TextAlign.end,
      ),
      visualDensity: const VisualDensity(horizontal: 4),
    ));
  }
}
