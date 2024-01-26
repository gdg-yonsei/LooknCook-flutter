import 'package:lookncook/apis/API.dart';
import 'package:lookncook/utils/Logger.dart';

class LCApis {
  static final LCApis instance = LCApis._internal();
  LCApis._internal();
  factory LCApis() => instance;
  static final API _api = API();

  Future<void> ping() async {
    var res = await _api.get("/ping");
    Logger().logSuccess(res["message"]);
  }
}
