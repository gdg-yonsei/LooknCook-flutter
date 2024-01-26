import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lookncook/utils/Logger.dart';

Future<http.Response> fetchAlbum() async {
  await dotenv.load(fileName: ".env");
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

class API {
  static final API instance = API._internal();
  static late final String _baseUrl;
  static final Map<String, String> _headers = {};
  API._internal();

  factory API() => instance;

  Future<void> init() async {
    String? baseUrl = dotenv.env['GO_SERVER'];
    Logger().logInfo("======baseUrl $baseUrl");
    if (baseUrl == null) {
      throw Exception('Failed to load env base url');
    } else {
      _baseUrl = baseUrl;
    }
  }

  // void setHeaderToken(String token) {
  //   _headers["DEVICE-ID"] = token;
  // }

  Future<Map<String, dynamic>> get(String url,
      {Map<String, String>? headers}) async {
    String url_ = '$_baseUrl$url';
    Logger().logInfo(url_);

    var res = await http.get(
      Uri.parse(url_),
      headers: headers == null ? _headers : {..._headers, ...headers},
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return body;
    } else {
      throw Exception('[API] failed to get data');
    }
  }

  Future<Map<String, dynamic>> post(String url,
      {Map<String, String>? headers, dynamic data}) async {
    String url_ = '$_baseUrl$url';
    Logger().logInfo(url_);

    var res = await http.post(Uri.parse(url_),
        headers: headers == null ? _headers : {..._headers, ...headers},
        body: data);

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return body;
    } else {
      throw Exception('[API] failed to get data');
    }
  }

  Future<void> postMultipart(
    String url,
    Map<String, dynamic> data, {
    Map<String, String>? headers,
  }) async {
    String url_ = '$_baseUrl$url';
    Logger().logInfo(url_);

    var request = http.MultipartRequest("POST", Uri.parse(url_));

    for (String key in data.keys) {
      var value = data[key];
      if (value is File) {
        var bytes = value.readAsBytesSync();
        request.files.add(http.MultipartFile.fromBytes(key, bytes,
            contentType: MediaType('image', 'jpeg')));
      } else {
        request.fields[key] = value;
      }
    }

    var res = await request.send();
    if (res.statusCode == 200) {
      // TODO: http response to data;
      print(res);
    } else {
      throw Exception('[API] failed to get data');
    }
  }
}
