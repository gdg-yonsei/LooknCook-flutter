import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/apis/apis.dart';
import 'package:lookncook/screens/fridge_result_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class CookEnvCameraScreen extends StatefulWidget {
  const CookEnvCameraScreen({Key? key}) : super(key: key);

  @override
  _CookEnvCameraScreenState createState() => _CookEnvCameraScreenState();
}

class _CookEnvCameraScreenState extends State<CookEnvCameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final FlutterTts tts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
    listenForPermissions();
    tts.speak(
        "Once you’re ready to begin, please take a photo of the cooking environment. I will identify the location of cooking utensils and any potential hazards. When you are prepared, please say “Capture Photo”.");
    if (!_speechEnabled) {
      _initSpeech();
    }
  }

  void _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras[0], // Use the first camera in the list
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    await Future.delayed(const Duration(seconds: 5), () => _startListening());
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 10),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }

  Future<void> _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.recognizedWords == "Capture Photo") {
      var xFile = await _controller.takePicture();
      Get.to(() => FridgeResultScreen(imageFile: File(xFile.path)));
    }
    setState(() {});
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  height: 670,
                  child: CameraPreview(_controller),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () async {
              await _initializeControllerFuture;
              var xFile = await _controller.takePicture();
              Get.to(() => FridgeResultScreen(imageFile: File(xFile.path)));
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
