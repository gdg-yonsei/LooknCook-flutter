import 'package:lookncook/dtos/Ingredient.dart';
import 'package:lookncook/dtos/Recipe.dart';
import 'package:lookncook/dtos/cook_env_state.dart';
import 'package:lookncook/dtos/enums.dart';
import 'package:lookncook/dtos/recipe_step.dart';

final List<Ingredient> dummyIngredients = [
  Ingredient(
      name: "White Beans",
      locationDescription:
          "On the top shelf, the first container on the left has white beans in it"),
  Ingredient(
      name: "Rice",
      locationDescription:
          "On the top shelf, the second container has rice in it."),
  Ingredient(
      name: "Green Beans",
      locationDescription:
          "On the top shelf, the third container on the right has green beans in it"),
  Ingredient(
      name: "Cheese",
      locationDescription:
          "On the middle shelf, the first container on the left has yellow cheese in it"),
  Ingredient(
      name: "Brown Rice",
      locationDescription:
          "On the middle shelf, the second container has brown rice in it."),
  Ingredient(
      name: "Pasta",
      locationDescription:
          "On the middle shelf, The third container has pasta in it."),
  Ingredient(
      name: "Eggs",
      locationDescription:
          "On the middle shelf, the fourth container has eggs in it."),
  Ingredient(
      name: "Cherry Tomatoes",
      locationDescription:
          "On the middle shelf, the fifth container has cherry tomatoes in it."),
  Ingredient(
      name: "Cucumbers",
      locationDescription:
          "On the middle shelf, the sixth container on the right has cucumbers in it."),
  Ingredient(
      name: "Broccoli",
      locationDescription:
          "On the bottom shelf, the first container on the left has broccoli in it. "),
  Ingredient(
      name: "Red Peppers",
      locationDescription:
          "On the bottom shelf, the second container has red peppers in it."),
  Ingredient(
      name: "Ham Hock",
      locationDescription:
          "On the bottom shelf, the third container has a ham hock in it."),
  Ingredient(
      name: "Salad Mix",
      locationDescription:
          "On the bottom shelf, the fourth container on the right has salad mix in it."),
];

final List<Recipe> recipeList = [
  Recipe(
      name: "Cheesy White Bean Rice Bowl",
      steps: [
        RecipeStep(
            index: 1,
            title: "Cook Ingredients",
            body:
                "Cook white beans and rice separately according to package instructions.",
            threat: []),
        RecipeStep(
            index: 2,
            title: "Mixing Beans & Rice ",
            body: "Mix cooked white beans and rice in a bowl.",
            threat: []),
        RecipeStep(
            index: 3,
            title: "Cheese Topping",
            body: "Add grated cheese on top. ",
            threat: []),
        RecipeStep(
            index: 4,
            title: "Microwaving Melting",
            body: "Microwave for 1-2 minutes or until the cheese melts.",
            threat: [CookThreat.microwave]),
        RecipeStep(
            index: 5,
            title: "Steaming Green Beans",
            body: "Serve with a side of steamed green beans.",
            threat: [CookThreat.steaming]),
      ],
      level: RecipeLevel.easy,
      likeCount: 24,
      ingredients: dummyIngredients
          .where(
            (i) => [
              "White Beans",
              "Rice",
              "Cheese",
              "Green Beans",
            ].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://dishingouthealth.com/wp-content/uploads/2023/01/WhiteBeanLemonSoupIG.jpg"),
  Recipe(
      name: "Veggie Pasta Salad",
      steps: [],
      level: RecipeLevel.easy,
      likeCount: 12,
      ingredients: dummyIngredients
          .where(
            (i) => [
              "Pasta",
              "Cherry Tomatoes",
              "Cucumbers",
              "Broccoli",
              "Red Peppers",
              "Ham Hock",
            ].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://www.daisybeet.com/wp-content/uploads/2021/05/Roasted-Vegetable-Pasta-Salad-8920.jpg"),
  Recipe(
      name: "Ham and Cheese Omelette",
      steps: [
        RecipeStep(
          index: 1,
          title: "Egg Whisking",
          threat: [],
          body: "Whisk eggs in a bowl.",
        ),
        RecipeStep(
          index: 2,
          title: "Ham Cooking",
          threat: [CookThreat.fire],
          body: "Cook diced ham hock in a pan until browned.",
        ),
        RecipeStep(
          index: 3,
          title: "Egg Pouring",
          threat: [CookThreat.fire],
          body: "Pour whisked eggs into the pan.",
        ),
        RecipeStep(
          index: 4,
          title: "Cheese Folding",
          threat: [CookThreat.knife],
          body: "Add cheese on one side, then fold the omelette.",
        ),
        RecipeStep(
          index: 5,
          title: "Cheese Melting",
          threat: [CookThreat.fire],
          body: "Cook until the cheese is melted.",
        ),
      ],
      level: RecipeLevel.easy,
      likeCount: 75,
      ingredients: dummyIngredients
          .where(
            (i) => [
              "Eggs",
              "Ham Hock",
              "Cheese",
            ].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://i0.wp.com/3scoopsofsugar.com/wp-content/uploads/2020/04/omelette6.jpg?w=667&ssl=1"),
  Recipe(
      name: "Brown Rice and Veggie Stir-Fry",
      steps: [],
      level: RecipeLevel.normal,
      likeCount: 24,
      ingredients: dummyIngredients
          .where(
            (i) => [
              "Brown Rice",
              "Green Beans",
              "Cherry Tomatoes",
              "Red Peppers",
            ].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://plantbasedonabudget.com/wp-content/uploads/2019/10/Vegan-Brown-Rice-Veggie-Stir-Fry-Plant-Based-on-a-Budget-15.jpg"),
  Recipe(
      name: "Mediterranean Rice and Salad Bowl",
      steps: [],
      level: RecipeLevel.easy,
      likeCount: 42,
      ingredients: dummyIngredients
          .where(
            (i) => [
              "White Rice",
              "Salad Mix",
              "Cherry Tomatoes",
              "Cucumbers",
              "Feta Cheese",
            ].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://www.recipetineats.com/wp-content/uploads/2020/09/Brown-Rice-Salad_8.jpg"),
  Recipe(
      name: "Broccoli and Cheese Stuffed Baked Potatoes",
      steps: [],
      level: RecipeLevel.normal,
      likeCount: 45,
      ingredients: dummyIngredients
          .where(
            (i) => ["Potatoes", "Broccoli", "Cheese"].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://static.onecms.io/wp-content/uploads/sites/19/2008/01/01/broccoli-potatoes-ay-1875529-x.jpg"),
  Recipe(
      name: "Ham Hock and White Bean Soup",
      steps: [],
      level: RecipeLevel.normal,
      likeCount: 12,
      ingredients: dummyIngredients
          .where(
            (i) => [
              "White Beans",
              "Ham Hock",
              "Cherry Tomatoes",
              "Green Beans",
              "Red Peppers",
            ].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://recipes.net/wp-content/uploads/2023/05/white-bean-and-ham-hock-soup-recipe_190e3a7f1ce256d59e785add9f9180fc.jpeg"),
  Recipe(
      name: "Rice and Veggie Sushi Rolls",
      steps: [],
      level: RecipeLevel.hard,
      likeCount: 26,
      ingredients: dummyIngredients
          .where(
            (i) => [
              "White Rice",
              "Seaweed Sheets",
              "Cherry Tomatoes",
              "Cucumbers",
              "Green Beans",
            ].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://www.happyfoodstube.com/wp-content/uploads/2020/04/rice-paper-sushi-image.jpg")
];

final List<CookEnvState> dummyCookEnvState = [
  CookEnvState(
      type: CookEnvType.fire,
      content:
          " it seems the induction cooktop is on and hot. Let's locate the control panel together to turn it off for safety before we continue with your cooking."),
  CookEnvState(
      type: CookEnvType.cookery,
      content:
          "The pot is in the middle of the cooktop, with the handle pointing towards you. Reach out in front of you, and you'll find it at your 12 o'clock position."),
  CookEnvState(
      type: CookEnvType.knife,
      content:
          "There's a sharp knife on your right side, with the blade pointing to the left. Reach to your 3 o'clock position, and you'll find the handle. Please be cautious when handling it."),
  CookEnvState(
      type: CookEnvType.rotten,
      content:
          "It seems the egg is spoiled. I suggest disposing of it to avoid any issues."),
];
