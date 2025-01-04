import 'package:call_simulation/ringtone_manager.dart';
import 'package:call_simulation/incoming_call_dialog.dart';
import 'package:call_simulation/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'call_state_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final callStateProvider = Provider.of<CallStateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Initiate Call'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current State: ${callStateProvider.state.name}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                callStateProvider.updateState(CallState.inCall);
                Navigator.pushNamed(
                  context,
                  '/call',
                  arguments: CallScreenArgs(
                    isVoiceCall: false,
                  ),
                );
              },
              child: const Text('Start Video Call'),
            ),
            ElevatedButton(
              onPressed: () {
                callStateProvider.updateState(CallState.inCall);
                Navigator.pushNamed(
                  context,
                  '/call',
                  arguments: CallScreenArgs(
                    isVoiceCall: true,
                  ),
                );
              },
              child: const Text('Start Audio Call'),
            ),
            ElevatedButton(
              onPressed: () {
                callStateProvider.updateState(CallState.ringing);
                RingtoneManager manager = RingtoneManager();
                manager.startRinging(
                  onStopRinging: () {
                    callStateProvider.updateState(CallState.idle);
                    Navigator.pop(context);
                  },
                );
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return IncomingCallDialog(
                      callStateProvider: callStateProvider,
                      ringtoneManager: manager,
                    );
                  },
                );
              },
              child: const Text('Simulate Incoming Call'),
            ),
          ],
        ),
      ),
    );
  }
}
