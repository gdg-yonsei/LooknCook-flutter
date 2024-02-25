import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class CookFinishScreen extends StatefulWidget {
  const CookFinishScreen({super.key});

  @override
  State<CookFinishScreen> createState() => _CookFinishScreenState();
}

class _CookFinishScreenState extends State<CookFinishScreen> {
  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    tts.setLanguage('en');
    tts.setSpeechRate(0.5);
    tts.speak('Bon Appétit!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: Text("Finish!",
              style: context.textTheme.displaySmall?.apply(
                  fontWeightDelta: 5,
                  color: Theme.of(context).colorScheme.onPrimary))),
    );
  }
}
