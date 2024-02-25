import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/screens/%08tutorial_list_screen/tutorial_list_screen.dart';
import 'package:lookncook/screens/camera_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<CameraDescription>> cameras = availableCameras();

  @override
  void initState() {
    super.initState();
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    // listenForPermissions();
    listenForPermissions();
    tts.speak(
        "Press the capture button on the bottom center, or say “Take Picture” to take a photo. ");
    tts.setCompletionHandler(() {
      if (!_speechEnabled) {
        _initSpeech();
      }
    });
  }

  final FlutterTts tts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    _startListening();
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 10),
      localeId: "en_En",
    );
    setState(() {});
  }

  Future<void> _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.recognizedWords == "start camera") {
      Get.to(() => const CameraScreen());
    }
  }

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
        break;
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 320,
            child: Image.asset('assets/image/LC_Logo.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              Get.to(() => const CameraScreen());
            },
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Begin",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              "Take a picture of your refrigerator and begin!",
              style: context.textTheme.displaySmall?.apply(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeightDelta: 2),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              "Enhance your culinary skills before you start creating delicious dishes!",
              style: context.textTheme.titleLarge?.apply(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeightDelta: 1),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.to(() => TutorialListScreen());
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Discover Cooking Tips",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
