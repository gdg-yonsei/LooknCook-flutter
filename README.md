# LookNCook

## 🥗 Overview

Hello, We are LookNCook!

LookNCook is a Flutter mobile application designed to empower visually impaired seniors with a comprehensive and safe cooking experience. 
This project aims to address the goal of ending all forms of malnutrition, submitted for the [Google Solution Challenge 2024](https://developers.google.com/community/gdsc-solution-challenge).

❗️ This repository only contains the Flutter code for the mobile app implementation of LookNCook. (➡️ [LookNCook Overview Github](https://github.com/gdsc-ys/LookNCook))

## 📂 Project Structure

```
lib/
├── apis/
│   ├── API.dart (API caller class)
│   └── apis.dart (Define your API endpoints here)
├── components/ (Reusable components across screens)
├── dtos/ (Data transfer objects and enums)
└── screens/ 
    ├── home_screen.dart
    ├── health_info_screen.dart (User health info input)
    ├── tutorial_list_screen.dart (Curated cooking tutorials with YouTube & Gemini)
    ├── camera_screen.dart (Refrigerator ingredient scanning)
    ├── fridge_result_screen.dart (Displays detected ingredients)
    ├── recipe_list_screen.dart (Shows recipes based on available ingredients)
    ├── ingredient_preparation_screen.dart (Guides ingredient preparation)
    ├── cook_env_camera_screen.dart (Scans cooking environment for hazards)
    ├── cook_env_result_screen.dart (Lists detected hazards)
    ├── cooking_screen.dart (Step-by-step recipe guidance)
    └── cook_finish_screen.dart (Recipe completion screen)
```

## 🪜 Prerequisites

### Environment File (.env)
Place environment file in the root of the app project.
```
GO_SERVER=[YOUR GO SERVER URL]
GCP_API_KEY=[YOUR GOOGLE CLOUD API KEY]
GEMINI_KEY=[YOUR GOOGLE CLOUD GENERATIVE LANGUAGE API KEY]
```
### Firebase Configuration
```    
flutterfire configure --project=[YOUR FIREBASE PROJECT NAME]
```

### Accessibility
Enable Google Talkback in your device's accessibility settings.


## 📱 Running the App

```
flutter run
```

## 🔑 Key Features

* **Ingredient Detection:** Scan your refrigerator for available ingredients.
* **Recipe Recommendations:** Get recipes tailored to your ingredients.
* **Cooking Tutorials:** Access curated tutorials using YouTube and Gemini (generative language assistance).
* **Hazard Detection:** Identify potential kitchen hazards for enhanced safety.
* **Step-by-Step Guidance:** Receive audio instructions throughout the cooking process.
* **Emergency Situation Detection:** Trigger emergency situation mode when hearing specific words or loud noises.