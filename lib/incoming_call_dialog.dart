import 'package:call_simulation/call_state_provider.dart';
import 'package:call_simulation/ringtone_manager.dart';
import 'package:call_simulation/route_arguments.dart';
import 'package:flutter/material.dart';

class IncomingCallDialog extends StatelessWidget {
  const IncomingCallDialog({
    super.key,
    required this.callStateProvider,
    required this.ringtoneManager,
  });

  final CallStateProvider callStateProvider;
  final RingtoneManager ringtoneManager;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Incoming Call',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'You have an incoming call',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            ringtoneManager.stopRinging();
            callStateProvider.updateState(CallState.inCall);
            Navigator.pushNamed(
              context,
              '/call',
              arguments: CallScreenArgs(
                isVoiceCall: true,
              ),
            );
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          icon: const Icon(
            Icons.call,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            ringtoneManager.stopRinging();
            callStateProvider.updateState(CallState.inCall);
            Navigator.pushNamed(
              context,
              '/call',
              arguments: CallScreenArgs(
                isVoiceCall: false,
              ),
            );
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          icon: const Icon(
            Icons.video_call_rounded,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {
            ringtoneManager.stopRinging();
            callStateProvider.updateState(CallState.idle);
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text(
            'Reject',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
