import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_bloc/features/presentation/screens/camera/picture_review.dart';
import 'package:new_flutter_bloc/features/presentation/widgets/library_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class WhatsappCameraScreen extends StatefulWidget {
  @override
  _WhatsappCameraScreenState createState() => _WhatsappCameraScreenState();
}

class _WhatsappCameraScreenState extends State<WhatsappCameraScreen>
    with WidgetsBindingObserver {
  ScrollController _scrollController = new ScrollController();

  List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _selected = 0;

  AssetPathEntity? _libraryPath;
  List<File> _libraryImageList = [];

  // Pagination image from library
  int _currentPage = 0;
  int _totalCount = 1;
  int _perPage = 20;
  bool _isLibraryLoading = false;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    WidgetsBinding.instance?.addObserver(this);
  }

  void _requestPermission() async {
    await [
      Permission.camera,
      Permission.mediaLibrary,
      Permission.microphone,
    ].request();
    setupCamera();
    _setupScrollController();
    _initializeLibrary();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_controller == null ||
        !(_controller != null && _controller!.value.isInitialized)) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      setupCamera();
    }
  }

  void _setupScrollController() {
    _scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.6 * _scrollController.position.maxScrollExtent;

        if (!_isLibraryLoading && _currentPage * _perPage < _totalCount) {
          if (_scrollController.position.pixels > triggerFetchMoreSize) {
            _loadImageFromGallery();
          }
        }
      });
  }

  // CAMERA
  Future<void> setupCamera() async {
    _cameras = await availableCameras();
    var controller = await selectCamera();
    setState(() => _controller = controller);
  }

  Future<CameraController> selectCamera() async {
    var controller =
        CameraController(_cameras[_selected], ResolutionPreset.low);

    await controller.initialize();
    return controller;
  }

  void toggleCamera() async {
    int newSelected = (_selected + 1) % _cameras.length;
    _selected = newSelected;

    var controller = await selectCamera();
    setState(() => _controller = controller);
  }

  void _takePicture() async {
    try {
      final image = await _controller?.takePicture();
      if (image != null) {
        _navigateToPreview(File(image.path));
      }
    } catch (e) {
      print("Error taking picture");
    }
  }

  void _navigateToPreview(File image) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PictureReviewScreen(
          image,
        ),
      ),
    );
  }

  // LIBRARY
  void _initializeLibrary() async {
    List<AssetPathEntity> list = await PhotoManager.getAssetPathList(
        type: RequestType.image, hasAll: true);
    if (list.length > 0) {
      _libraryPath = list[0];
      _totalCount = _libraryPath!.assetCount;
      _loadImageFromGallery();
    }
  }

  void _loadImageFromGallery() async {
    if (_libraryPath != null) {
      setState(() {
        _isLibraryLoading = true;
      });
      final response = await _libraryPath!.getAssetListPaged(
        _currentPage,
        _perPage,
      );
      List<File> transformData = _libraryImageList;

      await Future.forEach(response, (AssetEntity element) async {
        final fileData = await element.file;
        if (fileData != null) {
          transformData.add(fileData);
        }
      });
      setState(() {
        _currentPage++;
        _libraryImageList = transformData;
        _isLibraryLoading = false;
      });
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

  Widget _buildCameraActions() {
    return Column(
      children: [
        Container(
          height: 80,
          child: ListView.builder(
            addAutomaticKeepAlives: true,
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _libraryImageList.length,
            itemBuilder: (context, index) {
              final item = _libraryImageList[index];
              return LibraryImage(
                item: item,
                onTap: () {
                  _navigateToPreview(item);
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(48, 24, 48, 48),
          child: Center(
            child: InkResponse(
              child: Icon(
                Icons.blur_circular_rounded,
                color: Colors.white,
                size: 64,
              ),
              onTap: _takePicture,
            ),
          ),
        ),
      ],
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
