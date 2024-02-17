import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:lookncook/constants/dummy.dart';
import 'package:lookncook/screens/camera_screen.dart';
import 'package:lookncook/screens/cook_env_result_screen/cook_env_result_screen.dart';
import 'package:lookncook/screens/cooking_screen/cooking_screen.dart';
import 'package:lookncook/screens/emergency_situation_screen.dart';
import 'package:lookncook/screens/fridge_result_screen.dart';
import 'package:lookncook/screens/ingredient_preparation_screen/ingredient_preparation_screen.dart';
import 'package:lookncook/screens/recipe_list_screen/recipe_list_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Future<List<CameraDescription>> cameras = availableCameras();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 320,
            child: Image.asset('assets/image/LC_Logo.png'),
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: cameras,
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  return ElevatedButton(
                    onPressed: () async {
                      Get.to(() => CameraScreen(
                            cameras: snapShot.data!,
                          ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Begin",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              "Take a picture of your refrigerator and begin!",
              style: context.textTheme.displaySmall?.apply(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeightDelta: 2),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
