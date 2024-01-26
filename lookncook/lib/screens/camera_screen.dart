import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lookncook/apis/apis.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    initializeCamera(selectedCamera); //Initially selectedCamera = 0
    super.initState();
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
    listenForPermissions();
    tts.speak(
        "Press the shooting button in the bottom center or say ‘shooting’");
    if (!_speechEnabled) {
      _initSpeech();
    }
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
      widget.cameras[cameraIndex],
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
    print("여기 맞지?..");
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 10),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    print("뭔데...");
    setState(() {});
  }

  Future<void> _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.recognizedWords == "shooting") {
      debugPrint("오키 좋았어!?..");
      var xFile = await _controller.takePicture();
      capturedImages.add(File(xFile.path));
      debugPrint("개꿀!?..");
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
    return Scaffold(
      backgroundColor: Colors.black,
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
              setState(() {
                capturedImages.add(File(xFile.path));
              });
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
