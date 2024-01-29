import 'package:lookncook/dtos/enums.dart';

class RecipeStep {
  final int index;
  final String title, body;
  final List<CookThreat> threat;

  RecipeStep(
      {required this.index,
      required this.title,
      required this.body,
      required this.threat});
}
