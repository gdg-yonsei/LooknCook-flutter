import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencySituationScreen extends StatelessWidget {
  const EmergencySituationScreen({super.key});

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
