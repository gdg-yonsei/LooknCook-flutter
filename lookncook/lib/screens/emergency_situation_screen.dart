import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class EmergencySituationScreen extends StatefulWidget {
  const EmergencySituationScreen({super.key});

  @override
  State<EmergencySituationScreen> createState() =>
      _EmergencySituationScreenState();
}

class _EmergencySituationScreenState extends State<EmergencySituationScreen> {
  final FlutterTts tts = FlutterTts();
  void speakWithTts() async {
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    await tts.speak(
      "Emergency situation detected! Please explain the emergency situation. A emergency notification will be sent to the registered guardian’s number.",
    );
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
