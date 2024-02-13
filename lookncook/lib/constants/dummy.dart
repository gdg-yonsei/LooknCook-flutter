import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/dtos/cook_env_state.dart';
import 'package:lookncook/dtos/enums.dart';
import 'package:lookncook/dtos/ingredient.dart';
import 'package:lookncook/dtos/recipe_step.dart';

final List<Ingredient> dummyIngredients = [
  Ingredient(
      name: "White Beans",
      locationDescription:
          "On the top shelf, the first container on the left has white beans in it",
      thumbnailImage:
          "https://www.knowyourproduce.com/wp-content/uploads/2021/11/instant-pot-white-beans.jpg"),
  Ingredient(
      name: "Rice",
      locationDescription:
          "On the top shelf, the second container has rice in it.",
      thumbnailImage:
          'https://www.world-grain.com/ext/resources/2022/10/25/Rice_AdobeStock_64819529_E.jpg?height=667&t=1666706505&width=1080'),
  Ingredient(
      name: "Green Beans",
      locationDescription:
          "On the top shelf, the third container on the right has green beans in it",
      thumbnailImage:
          "https://www.beyondthechickencoop.com/wp-content/uploads/2022/12/Blanched-Green-Beans-3.jpg"),
  Ingredient(
      name: "Cheese",
      locationDescription:
          "On the middle shelf, the first container on the left has yellow cheese in it",
      thumbnailImage:
          "https://ca-times.brightspotcdn.com/dims4/default/54847e8/2147483647/strip/true/crop/2048x1280+0+43/resize/1200x750!/quality/75/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Fb2%2Fa5%2Fd673ffac73e3ff63f2f3c095fde9%2Fhomemade-american-cheese-recipes-db"),
  Ingredient(
      name: "Brown Rice",
      locationDescription:
          "On the middle shelf, the second container has brown rice in it.",
      thumbnailImage:
          "https://dainty.ca/wp-content/uploads/2021/07/brown-rice-recipe-1.jpg"),
  Ingredient(
      name: "Pasta",
      locationDescription:
          "On the middle shelf, The third container has pasta in it.",
      thumbnailImage:
          "https://www.biggerbolderbaking.com/wp-content/uploads/2023/09/Penne-Pasta-Thumbnail-scaled.jpg"),
  Ingredient(
      name: "Eggs",
      locationDescription:
          "On the middle shelf, the fourth container has eggs in it.",
      thumbnailImage:
          "https://cdn.britannica.com/94/151894-050-F72A5317/Brown-eggs.jpg"),
  Ingredient(
      name: "Cherry Tomatoes",
      locationDescription:
          "On the middle shelf, the fifth container has cherry tomatoes in it.",
      thumbnailImage:
          "https://www.wholesomeyum.com/wp-content/uploads/2021/07/wholesomeyum-Carbs-In-Cherry-Tomatoes-Are-Cherry-Tomatoes-Keto-6.jpg"),
  Ingredient(
      name: "Cucumbers",
      locationDescription:
          "On the middle shelf, the sixth container on the right has cucumbers in it.",
      thumbnailImage:
          "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2022/07/15/0/FNK_Cucumber-Shot-H3_s4x3.jpg.rend.hgtvcom.1280.1280.suffix/1657897212314.jpeg"),
  Ingredient(
      name: "Broccoli",
      locationDescription:
          "On the bottom shelf, the first container on the left has broccoli in it. ",
      thumbnailImage:
          "https://images.immediate.co.uk/production/volatile/sites/30/2022/07/Broccoli-78ec54e.jpg?quality=90&resize=556,505"),
  Ingredient(
      name: "Red Peppers",
      locationDescription:
          "On the bottom shelf, the second container has red peppers in it.",
      thumbnailImage:
          "https://images.immediate.co.uk/production/volatile/sites/30/2020/02/Red-peppers-afa27f8.jpg?resize=768,574"),
  Ingredient(
      name: "Ham Hock",
      locationDescription:
          "On the bottom shelf, the third container has a ham hock in it.",
      thumbnailImage:
          "https://carnbrooke.com/wp-content/uploads/2021/10/Ham-Hock.jpg"),
  Ingredient(
      name: "Salad Mix",
      locationDescription:
          "On the bottom shelf, the fourth container on the right has salad mix in it.",
      thumbnailImage:
          "https://www.homemadeinterest.com/wp-content/uploads/2023/03/Mixed-Green-Salad_2.jpg"),
];

final List<Recipe> dummyRecipeList = [
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
      level: RecipeLevel.medium,
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
      level: RecipeLevel.medium,
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
      level: RecipeLevel.medium,
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
