import 'package:lookncook/dtos/Ingredient.dart';
import 'package:lookncook/dtos/enums.dart';
import 'package:lookncook/dtos/recipe_step.dart';

class Recipe {
  final String name, thumbnailImage;
  final List<RecipeStep> steps;
  final RecipeLevel level;
  final int likeCount;
  final List<Ingredient> ingredients;

  Recipe(
      {required this.name,
      required this.steps,
      required this.level,
      required this.likeCount,
      required this.ingredients,
      required this.thumbnailImage});
}
