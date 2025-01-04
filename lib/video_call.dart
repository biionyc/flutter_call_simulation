import 'package:call_simulation/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({super.key});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;
  int _currentCameraIndex = 1;
  bool _hasCameraPermission = false;

  @override
  void initState() {
    super.initState();
    setCameras();
  }

  void setCameras() async {
    bool status = await PermissionHandler().hasPermissions(context);
    setState(() {
      _hasCameraPermission = status;
    });
    if (status) {
      final List<CameraDescription> cameras = await availableCameras();
      setState(() {
        _cameras = cameras;
      });
      _initializeCamera(_currentCameraIndex);
    }
  }

  void _initializeCamera(int cameraIndex) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }

    _cameraController = CameraController(
      _cameras[cameraIndex],
      ResolutionPreset.high,
    );

    try {
      await _cameraController!.initialize();
    } catch (e) {
      print("Error initializing camera: $e");
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _switchCamera() {
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
    _initializeCamera(_currentCameraIndex);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/call_placeholder.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: _cameras.isEmpty &&
                    !(_cameraController?.value.isInitialized ?? false)
                ? Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(50),
                        child: Icon(
                          Icons.person_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      if (!_hasCameraPermission)
                        Positioned(
                          bottom: 5,
                          right: 50,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(0),
                            ),
                            onPressed: setCameras,
                            icon: const Icon(
                              Icons.block_rounded,
                              size: 30,
                              color: Colors.red,
                            ),
                          ),
                        )
                    ],
                  )
                : Stack(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 50,
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(0),
                          ),
                          onPressed: _switchCamera,
                          icon: const Icon(
                            Icons.cameraswitch_rounded,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
