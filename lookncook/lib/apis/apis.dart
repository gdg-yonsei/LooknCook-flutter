import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lookncook/apis/API.dart';
import 'package:lookncook/dtos/cook_tutorial.dart';
import 'package:lookncook/utils/Logger.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class LCApis {
  static final LCApis instance = LCApis._internal();
  LCApis._internal();
  factory LCApis() => instance;
  static final API _api = API();

  Future<void> ping() async {
    var res = await _api.get("/ping");
    if (res["message"] == "pong") {
      Logger().logSuccess("API test succeeded");
    }
  }

  Future<String> uploadFridge(File image) async {
    var res = await _api.postMultipart(
      "/GetFridgeRecipe",
      {"image": image},
      headers: {
        "Content-Type": "multipart/form-data",
      },
    );

    return "";
  }

  Future<String> uploadCookEnv(File image) async {
    var res = await _api.postMultipart(
      "/GetKitchenEnvironment",
      {"image": image},
      headers: {
        "Content-Type": "multipart/form-data",
      },
    );

    return "";
  }

  CookTutorial _processVideoItem(i) {
    var snippet = i["snippet"];
    var id = i["id"];

    return CookTutorial(
        description: snippet["description"],
        thumbnail: snippet["thumbnails"]["default"]["url"],
        title: snippet["title"],
        url: "https://www.youtube.com/watch?v=${id["videoId"]}");
  }

  Future<List<CookTutorialCategory>> getTutorials() async {
    String? apiKey = dotenv.env["GCP_API_KEY"];
    String? geminiKey = dotenv.env["GEMINI_KEY"];

    try {
      if (apiKey == null || geminiKey == null) {
        throw Error();
      }

      var res = await _api.getFromOpenApi(
        'https://youtube.googleapis.com/youtube/v3/search?part=snippet&part=id&maxResults=25&q=blind%20cooking%20tips&key=$apiKey',
      );

      var items = res["items"];

      List<CookTutorial> videos =
          items.map<CookTutorial>(_processVideoItem).toList();

      String prompt = [
        "DO NOT INCLUDE BACKTICKS OR \n or \ IN THE RESPONSE.",
        "Do not use Markdown in the response",
        "You will given a list of title and part of description of youtube videos about blind cooking tips.",
        "Based on the information, categorize these videos into 3 or 4 categories.",
        "One video might be included in several categories."
            "Then, generate the JSON list of map that contains two keys, one is \"category\", which has value of String category name, and \"titles\" which has value of list of String titles of videos that is included in that category.",
        "Response in a json format provided.",
        '[{"category":, "titles": },{"category":, "titles":},{"category":, "titles":}]',
        "Below is the information.",
        videos.map((i) {
          return "title: ${i.title}\ndescription: ${i.description}";
        }).join("\n\n")
      ].join("\n");

      final safetySettings = [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
      ];

      final model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: geminiKey,
          safetySettings: safetySettings);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text is String) {
        Clipboard.setData(ClipboardData(text: response.text!));

        var categoryRes = jsonDecode(response.text!);

        if (categoryRes is List) {
          List<CookTutorialCategory> res =
              categoryRes.map<CookTutorialCategory>((i) {
            return CookTutorialCategory(
                category: i["category"],
                videos: i["titles"].map<CookTutorial>((title) {
                  return videos.firstWhere((element) => element.title == title);
                }).toList());
          }).toList();
          return res;
        } else {
          throw Error();
        }
      } else {
        throw Error();
      }
    } catch (e) {
      Logger().logError(e.toString());
      Logger().logError("Error in fetching videos");
      return [];
    }
  }
}
