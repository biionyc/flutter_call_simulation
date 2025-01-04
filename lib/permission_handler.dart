import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> hasPermissions(BuildContext context) async {
    // Request both camera and microphone permissions
    var cameraStatus = await Permission.camera.request();
    var microphoneStatus = await Permission.microphone.request();

    bool hasPermission = false;

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      hasPermission = true;
    } else if (cameraStatus.isDenied || microphoneStatus.isDenied) {
      hasPermission = false;

      if (context.mounted) {
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            backgroundColor: Colors.white,
            content: const Text(
              'Camera and microphone access are required for this feature.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.4,
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } else if (cameraStatus.isPermanentlyDenied ||
        microphoneStatus.isPermanentlyDenied) {
      hasPermission = false;

      if (context.mounted) {
        showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            backgroundColor: Colors.white,
            content: const Text(
              'Camera or microphone access is permanently denied. Please enable it from settings to proceed.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.4,
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings(); // Open app settings for manual permission configuration
                },
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }

    return hasPermission;
  }
}
