import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/dtos/cook_env_state.dart';
import 'package:lookncook/dtos/enums.dart';
import 'package:lookncook/dtos/ingredient.dart';
import 'package:lookncook/dtos/recipe_step.dart';

final List<Ingredient> dummyIngredients = [
  Ingredient(
      name: "Milk",
      locationDescription:
          "On the top shelf, the first item is a bottle of milk.",
      thumbnailImage:
          "https://as1.ftcdn.net/v2/jpg/01/06/68/88/500_F_106688812_rVoRFXazgIMEUJdvffG9p0XvP8Lntf0a.jpg"),
  Ingredient(
      name: "Rice",
      locationDescription:
          "On the top shelf, the second container has rice in it.",
      thumbnailImage:
          'https://www.world-grain.com/ext/resources/2022/10/25/Rice_AdobeStock_64819529_E.jpg?height=667&t=1666706505&width=1080'),
  Ingredient(
      name: "Potatoes",
      locationDescription:
          "On the top shelf, there are potatoes on the right side",
      thumbnailImage:
          "https://www.harighotra.co.uk/images/Shutterstock/Potatoes_560x560.jpg"),
  Ingredient(
      name: "Onion",
      locationDescription: "On the top shelf, there is onion on the right side",
      thumbnailImage:
          "https://images.immediate.co.uk/production/volatile/sites/30/2019/08/Onion-72ea178.jpg?resize=768,574"),
  Ingredient(
      name: "Tomatoes",
      locationDescription:
          "On the second shelf, there are tomatoes on the left.",
      thumbnailImage:
          "https://biwaterfarm.com/wp-content/uploads/2019/03/tomatoes.jpg"),
  Ingredient(
      name: "Cheese",
      locationDescription:
          "On the second shelf, the second item is a block of cheese.",
      thumbnailImage:
          "https://ca-times.brightspotcdn.com/dims4/default/54847e8/2147483647/strip/true/crop/2048x1280+0+43/resize/1200x750!/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Fb2%2Fa5%2Fd673ffac73e3ff63f2f3c095fde9%2Fhomemade-american-cheese-recipes-db"),
  Ingredient(
      name: "Cabbage",
      locationDescription:
          "On the second shelf, The third item is a head of cabbage.",
      thumbnailImage:
          "https://greengarden.ph/cdn/shop/products/LINE_ALBUM_PICTURE_230412_85.jpg?v=1681290016"),
  Ingredient(
      name: "Carrot",
      locationDescription: "On the second shelf, The fourth item is a carrot.",
      thumbnailImage:
          "https://www.mp-engineering.co.uk/wp-content/uploads/2023/08/carrots-around-the-world.jpg"),
  Ingredient(
      name: "Eggs",
      locationDescription:
          "On the second shelf, the fifth container has eggs in it.",
      thumbnailImage:
          "https://cdn.britannica.com/94/151894-050-F72A5317/Brown-eggs.jpg"),
];

/**
 * 
 * Milk
Rice
Potatoes
Onion
Tomatoes
Cheese
Cabbage
Carrot
Eggs

 */
final List<Recipe> dummyRecipeList = [
  Recipe(
      name: "Tomato and Cheese Omelette",
      steps: [
        RecipeStep(
            index: 0,
            title: "Fake!!!",
            body:
                "Wash and dice tomatoes and onions. Use a sharp knife to ensure precision. For safety, consider using a cutting board with a non-slip surface.",
            threat: [CookThreat.knife]),
        RecipeStep(
            index: 1,
            title: "Prepare Vegetables",
            body:
                "Wash and dice tomatoes and onions. Use a sharp knife to ensure precision. For safety, consider using a cutting board with a non-slip surface.",
            threat: [CookThreat.knife]),
        RecipeStep(
            index: 2,
            title: "Sauté Vegetables",
            body:
                "In a pan, add a small amount of oil and sauté the diced tomatoes and onions until they are softened. Stir occasionally with a wooden spoon to prevent sticking.",
            threat: [CookThreat.fire]),
        RecipeStep(
            index: 3,
            title: "Grate Cheese",
            body:
                "Grate the cheese using a cheese grater. This adds a melty and savory component to the omelette. Exercise care to avoid contact with the grater's sharp edges.",
            threat: [CookThreat.knife]),
        RecipeStep(
          index: 4,
          title: "Whisk Eggs",
          body:
              "Crack two eggs into a bowl, then use a fork or whisk to beat them until the yolks and whites are well combined. This helps create a light and fluffy omelette.",
          threat: [],
        ),
        RecipeStep(
          index: 5,
          title: "Cook Eggs",
          body:
              "Heat a non-stick pan on the stove over medium heat. Pour the whisked eggs into the pan, ensuring an even spread. Allow them to cook undisturbed until the edges start to set.",
          threat: [CookThreat.fire],
        ),
        RecipeStep(
          index: 6,
          title: "Add Tomatoes, Onions, and Cheese",
          body:
              "Sprinkle diced tomatoes, onions, and shredded cheese onto one half of the omelette. This adds a flavorful filling to the dish.",
          threat: [],
        ),
        RecipeStep(
          index: 7,
          title: "Fold Omelette",
          body:
              "Gently lift the unfilled half of the omelette with a spatula and fold it over the filling. This creates a half-moon shape and encapsulates the delicious ingredients.",
          threat: [],
        ),
        RecipeStep(
          index: 8,
          title: "Finish Cooking",
          body:
              "Allow the omelette to cook for an additional minute, ensuring the cheese inside melts. The omelette is ready when the center is set but still moist.",
          threat: [CookThreat.fire],
        ),
      ],
      level: RecipeLevel.easy,
      likeCount: 24,
      ingredients: dummyIngredients
          .where(
            (i) => [
              "Eggs",
              "Tomatoes",
              "Onion",
              "Cheese",
            ].contains(i.name),
          )
          .toList(),
      thumbnailImage:
          "https://www.mygourmetconnection.com/wp-content/uploads/cheese-filled-omelette-tomatoes-scallions.jpg"),
  Recipe(
      name: "Cheesy Rice Casserole",
      steps: [],
      level: RecipeLevel.medium,
      likeCount: 12,
      ingredients: [],
      thumbnailImage:
          "https://www.realsimple.com/thmb/VCPU25PJn7Jg3Z_GaPikaHa6RF4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/creamy-potato-cabbage-soup-recipe1221DIN-44a8acb3054f4dcd9f665c0852e4f142.jpg"),
  Recipe(
      name: "Carrot and Cheese Stuffed Baked Potatoes",
      steps: [],
      level: RecipeLevel.medium,
      likeCount: 75,
      ingredients: [],
      thumbnailImage:
          "https://www.smells-like-home.com/wp-content/uploads/2017/03/roasted-vegetable-stuffed-potato-square-cropped.jpeg"),
  Recipe(
      name: "Creamy Cabbage and Cheese Pasta",
      steps: [],
      level: RecipeLevel.hard,
      likeCount: 15,
      ingredients: [],
      thumbnailImage:
          "https://hungryhealthyhappy.com/wp-content/uploads/2023/09/cabbage-pasta-featured.jpg"),
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
          "There's a sharp knife on your left side, with the blade pointing to the top. Reach to your 5 o'clock position, and you'll find the handle. Please be cautious when handling it."),
  CookEnvState(
      type: CookEnvType.rotten,
      content:
          "It seems the milk is out of date. I suggest disposing of it to avoid any issues."),
];
