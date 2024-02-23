import 'dart:io';
import 'package:lookncook/apis/API.dart';
import 'package:lookncook/utils/Logger.dart';

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
}
