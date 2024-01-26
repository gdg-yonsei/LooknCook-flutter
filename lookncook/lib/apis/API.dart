import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lookncook/utils/Logger.dart';

Future<http.Response> fetchAlbum() async {
  await dotenv.load(fileName: ".env");
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

// export interface APIInstance {
//   get<T>(url: string, config?: AxiosRequestConfig): Promise<T>;
//   delete<T>(url: string, config?: AxiosRequestConfig): Promise<T>;
//   post<T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<T>;
//   put<T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<T>;
//   patch<T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<T>;
// }

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

  void setHeaderToken(String token) {
    _headers["AUTH-TOKEN"] = token;
  }

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
}
