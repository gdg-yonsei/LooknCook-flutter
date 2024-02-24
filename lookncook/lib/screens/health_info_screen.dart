import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart'; // Import 'provider' if using it

// Example State Management class (using Provider)
class userInputData with ChangeNotifier {
  int _age = 45;
  List<String> _selectedDiseases = [];

  int get age => _age;
  List<String> get selectedDiseases => _selectedDiseases;

  void incrementAge() {
    _age++;
    notifyListeners();
  }

  void decrementAge() {
    _age--;
    notifyListeners();
  }

  void toggleDisease(String disease) {
    if (_selectedDiseases.contains(disease)) {
      _selectedDiseases.remove(disease);
    } else {
      _selectedDiseases.add(disease);
    }
    notifyListeners();
  }
}

class HealthInfoScreen extends StatefulWidget {
  const HealthInfoScreen({Key? key}) : super(key: key);

  @override
  State<HealthInfoScreen> createState() => _HealthInfoScreenState();
}

class _HealthInfoScreenState extends State<HealthInfoScreen> {
  // Sample Disease Options
  final List<String> _diseases = [
    'Cataracts',
    'Glaucoma',
    'Macular Degeneration',
    'Diabetic Retinopathy'
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<userInputData>(
      create: (_) => userInputData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Enter your information"),
        ),
        body: SingleChildScrollView(
          // To prevent overflow issues
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _buildAgeInput(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildMedicalHistoryInput(),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                _buildNextButton(context.textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "Age",
            style: context.textTheme.headlineMedium,
          ),
        ),
        Consumer<userInputData>(builder: (context, data, child) {
          return Semantics(
            container: true,
            label: 'Age Picker. Current age is ${data.age}',
            value: (data.age).toString(),
            increasedValue: (data.age + 1).toString(),
            decreasedValue: (data.age - 1).toString(),
            onIncrease: () => setState(() => data.incrementAge()),
            onDecrease: () => setState(() => data.decrementAge()),
            child: Column(
              children: [
                Text(
                  '${data.age}',
                  style: const TextStyle(fontSize: 36),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Semantics(
                      onTapHint: 'Decrease Age',
                      button: true,
                      child: ElevatedButton(
                        onPressed: () => setState(data.decrementAge),
                        child: const Text('-'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Semantics(
                      onTapHint: 'Increase Age',
                      button: true,
                      child: ElevatedButton(
                        onPressed: () => setState(data.incrementAge),
                        child: const Text('+'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        // Add a dial picker (package needed) or a numerical input field
      ],
    );
  }

  Widget _buildMedicalHistoryInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "Medical History",
            style: context.textTheme.headlineMedium,
          ),
        ),
        Consumer<userInputData>(builder: (context, data, child) {
          return Semantics(
            label: 'Medical history. Select your previous conditions',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _diseases.map((disease) {
                return ChoiceChip(
                  label: Text(disease),
                  selected: data.selectedDiseases.contains(disease),
                  onSelected: (isSelected) => data.toggleDisease(disease),
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildNextButton(TextTheme textTheme) {
    return Consumer<userInputData>(builder: (context, data, child) {
      return Semantics(
        label: "Next Button",
        button: true, // Indicate it's a button
        enabled: (data.age != 0 && data.selectedDiseases.isNotEmpty),
        onTapHint: 'Tap to proceed to the next screen', // Ac
        child: SizedBox(
            width: double.infinity, // Button takes full width
            child: ElevatedButton(
              onPressed: (data.age != 0 && data.selectedDiseases.isNotEmpty)
                  ? () {
                      // Navigate to next screen
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Next",
                  style: textTheme.titleLarge?.apply(fontWeightDelta: 2),
                  // style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )),
      );
    });
  }
}
