import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: Image.asset('assets/image/GDSC_Logo.png'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(350, 300),
          ),
          onPressed: () {
            print("찍혔다!..");
          },
          child: const Center(
            child: Text(
              "냉장고 사진 찍고 \n시작하기",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
