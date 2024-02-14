import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lookncook/apis/apis.dart';
import 'package:lookncook/constants/dummy.dart';
import 'package:lookncook/dtos/recipe.dart';
import 'package:lookncook/screens/cook_env_result_screen/cook_env_result_screen.dart';
import 'package:lookncook/screens/fridge_result_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class CookEnvCameraScreen extends StatefulWidget {
  final Recipe recipe;

  const CookEnvCameraScreen({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  _CookEnvCameraScreenState createState() => _CookEnvCameraScreenState();
}

class _CookEnvCameraScreenState extends State<CookEnvCameraScreen> {
  late List<CameraDescription> cameras;
  bool initiated = false;

  initCameras() async {
    List<CameraDescription> camerasRes = await availableCameras();
    setState(() {
      cameras = camerasRes;
      initializeCamera(selectedCamera); //Initially selectedCamera = 0
      initiated = true;
    });

    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
    listenForPermissions();
    tts.speak(
        "Press the shooting button in the bottom center or say ‘shooting’");
    if (!_speechEnabled) {
      _initSpeech();
    }
  }

  @override
  void initState() {
    super.initState();
    initCameras();
  }

  final FlutterTts tts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  late CameraController _controller; //To control the camera
  late Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 0;
  List<File> capturedImages = [];

  final String _lastWords = "";

  initializeCamera(int cameraIndex) async {
    //  LCApis().uploadFridge(capturedImages[0]);
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras[cameraIndex],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
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
    );
    setState(() {});
  }

  Future<void> _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.recognizedWords == "shooting") {
      var xFile = await _controller.takePicture();
      capturedImages.add(File(xFile.path));
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
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!initiated) {
      return const Placeholder();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return SizedBox(height: 670, child: CameraPreview(_controller));
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              await _initializeControllerFuture;
              var xFile = await _controller.takePicture();
              Get.to(() => CookEnvResultScreen(
                  cookEnvStateList: dummyCookEnvState,
                  recipe: widget.recipe,
                  imageFile: File(xFile.path)));
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF3A683),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
