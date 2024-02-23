import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class EmergencySituationScreen extends StatefulWidget {
  const EmergencySituationScreen({super.key});

  @override
  State<EmergencySituationScreen> createState() =>
      _EmergencySituationScreenState();
}

class _EmergencySituationScreenState extends State<EmergencySituationScreen> {
  final FlutterTts tts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  void speakWithTts() async {
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    tts.speak(
      "Emergency situation detected! Please explain the emergency situation. A emergency notification will be sent to the registered guardian’s number.",
    );

    tts.setCompletionHandler(() {
      if (!_speechEnabled) {
        _initSpeech();
      }
    });
  }

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
    // 1. 여기서 사용자가 말한 내용을 119로 보내기!..
    // result.recognizedWords

    // 2. 그리고 다시 요리하기로 돌아가기
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    speakWithTts();
  }

  @override
  Widget build(BuildContext context) {
    Color errorColor = Theme.of(context).colorScheme.error;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: errorColor,
              size: 85,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Emergency situation\ndetected!",
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.apply(
                  color: errorColor, fontSizeDelta: 5, fontWeightDelta: 3),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Please describe the emergency\nin words.",
              style: context.textTheme.titleLarge?.apply(color: errorColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
