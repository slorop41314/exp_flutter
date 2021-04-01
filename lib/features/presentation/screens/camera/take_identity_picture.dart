import 'dart:io';

import 'package:camera/camera.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class TakeIdentityPicture extends StatefulWidget {
  @override
  _TakeIdentityPictureState createState() => _TakeIdentityPictureState();
}

class _TakeIdentityPictureState extends State<TakeIdentityPicture> {
  List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    setupCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> setupCamera() async {
    await [
      Permission.camera,
    ].request();
    _cameras = await availableCameras();
    var controller = await selectCamera();
    setState(() => _controller = controller);
  }

  selectCamera() async {
    var controller =
        CameraController(_cameras[_selected], ResolutionPreset.low);

    await controller.initialize();
    return controller;
  }

  toggleCamera() async {
    int newSelected = (_selected + 1) % _cameras.length;
    _selected = newSelected;

    var controller = await selectCamera();
    setState(() => _controller = controller);
  }

  // _processingImage(File imageFile) async {
  //   final FirebaseVisionImage visionImage =
  //       FirebaseVisionImage.fromFile(imageFile);

  //   final TextRecognizer textRecognizer =
  //       FirebaseVision.instance.textRecognizer();

  //   final VisionText visionText =
  //       await textRecognizer.processImage(visionImage);

  //   for (TextBlock block in visionText.blocks) {
  //     for (TextLine line in block.lines) {
  //       print(line);
  //     }
  //   }
  // }

  _takePicture() async {
    try {
      final image = await _controller?.takePicture();
      if (image != null) {
        // _processingImage(File(image.path));
        print(image.path);
      }
    } catch (e) {
      print("Error taking picture");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller == null
          ? Container(
              color: Colors.black,
            )
          : MaterialApp(
              home: CameraPreview(
                _controller!,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHeaderActions(context),
                      _buildCameraActions()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Padding _buildCameraActions() {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Center(
        child: InkResponse(
          child: Icon(
            Icons.blur_circular_rounded,
            color: Colors.white,
            size: 64,
          ),
          onTap: () {
            _takePicture();
          },
        ),
      ),
    );
  }

  Widget _buildHeaderActions(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
