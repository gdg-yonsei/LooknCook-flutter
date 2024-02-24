import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import 'provider' if using it

// Example State Management class (using Provider)
class userInputData with ChangeNotifier {
  int _age = 0;
  List<String> _selectedDiseases = [];

  int get age => _age;
  List<String> get selectedDiseases => _selectedDiseases;

  void setAge(int age) {
    _age = age;
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
              children: [
                _buildAgeInput(),
                _buildMedicalHistoryInput(),
                const SizedBox(height: 30), // Add spacing
                _buildNextButton(),
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
        const Text('Age'),
        Consumer<userInputData>(builder: (context, data, child) {
          return InputDecorator(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            child: Text(data.age.toString()),
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
        const Text('Medical History'),
        Consumer<userInputData>(builder: (context, data, child) {
          return Wrap(
            spacing: 8.0,
            children: _diseases.map((disease) {
              return ChoiceChip(
                label: Text(disease),
                selected: data.selectedDiseases.contains(disease),
                onSelected: (isSelected) => data.toggleDisease(disease),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildNextButton() {
    return Consumer<userInputData>(builder: (context, data, child) {
      return SizedBox(
        width: double.infinity, // Button takes full width
        child: ElevatedButton(
          onPressed: (data.age != 0 && data.selectedDiseases.isNotEmpty)
              ? () {
                  // Navigate to next screen
                }
              : null,
          child: const Text('Next'),
        ),
      );
    });
  }
}
