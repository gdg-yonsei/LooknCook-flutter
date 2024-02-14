import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lookncook/apis/API.dart';
import 'package:lookncook/apis/apis.dart';
import 'package:lookncook/screens/home_screen.dart';
import 'package:lookncook/theme/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Timer(const Duration(seconds: 2), () async {
    await dotenv.load(fileName: ".env");
    await API().init();
    // await LCApis().ping();
    FlutterNativeSplash.remove();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: const MaterialTheme(
        TextTheme(),
      ).light(),
      home: HomeScreen(),
    );
  }
}
