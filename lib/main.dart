import 'package:call_simulation/call_screen.dart';
import 'package:call_simulation/call_state_provider.dart';
import 'package:call_simulation/home.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  requestCameraAndMicrophonePermissions();
  runApp(
    ChangeNotifierProvider(
      create: (_) => CallStateProvider(),
      child: const MyApp(),
    ),
  );
}

void requestCameraAndMicrophonePermissions() async {
  await Permission.camera.request();
  await Permission.microphone.request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Simulation',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/call': (context) => const CallScreen(),
      },
    );
  }
}
