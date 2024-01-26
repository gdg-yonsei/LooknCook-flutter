import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:lookncook/screens/camera_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Future<List<CameraDescription>> cameras = availableCameras();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Image.asset('assets/image/LC_Logo.png'),
          ),
          FutureBuilder(
              future: cameras,
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 300),
                    ),
                    onPressed: () {
                      Get.to(() => CameraScreen(
                            cameras: snapShot.data!,
                          ));
                    },
                    child: const Center(
                      child: Text(
                        "냉장고 사진 찍고 \n시작하기",
                        style: TextStyle(fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}
