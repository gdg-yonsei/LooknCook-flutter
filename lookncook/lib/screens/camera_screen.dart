import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// class CameraScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;
//   const CameraScreen({
//     Key? key,
//     required this.cameras,
//   }) : super(key: key);
//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   @override
//   void initState() {
//     initializeCamera(selectedCamera); //Initially selectedCamera = 0
//     super.initState();
//   }

//   late CameraController _controller; //To control the camera
//   late Future<void>
//       _initializeControllerFuture; //Future to wait until camera initializes
//   int selectedCamera = 0;
//   List<File> capturedImages = [];

//   initializeCamera(int cameraIndex) async {
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.cameras[cameraIndex],
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );

//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey,
//       body: Column(
//         children: [
//           FutureBuilder(
//             future: _initializeControllerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return CameraPreview(_controller);
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     await _initializeControllerFuture;
//                     var xFile = await _controller.takePicture();
//                     setState(() {
//                       capturedImages.add(File(xFile.path));
//                     });
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

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
  }

  late CameraController _controller; //To control the camera
  late Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 0;
  List<File> capturedImages = [];

  initializeCamera(int cameraIndex) async {
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras[cameraIndex],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
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
