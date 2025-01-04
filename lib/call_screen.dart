import 'package:call_simulation/route_arguments.dart';
import 'package:call_simulation/video_call.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'call_state_provider.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  CallStateProvider? _callStateProvider;
  bool _isVoiceCall = false;
  final ValueNotifier<bool> _isMuted = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _callStateProvider = Provider.of<CallStateProvider>(context);
    _isVoiceCall =
        (ModalRoute.of(context)?.settings.arguments as CallScreenArgs)
            .isVoiceCall;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Call Screen'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[300],
        ),
        body: _isVoiceCall
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(50),
                        child: Icon(Icons.person_outlined, size: 150),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Seth McFarlane',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : const VideoCall(),
        bottomNavigationBar: ColoredBox(
          color: Colors.grey[300] ?? Colors.grey,
          child: Padding(
            padding: EdgeInsets.only(
              top: 15,
              bottom: MediaQuery.paddingOf(context).bottom + 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ValueListenableBuilder(
                  valueListenable: _isMuted,
                  builder: (context, isMuted, child) {
                    return IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: isMuted ? Colors.grey : Colors.white,
                      ),
                      onPressed: () {
                        _isMuted.value = !isMuted;
                      },
                      color: isMuted ? Colors.white : Colors.grey,
                      icon: Icon(
                        isMuted ? Icons.mic_off : Icons.mic,
                        size: 30,
                      ),
                    );
                  },
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    _callStateProvider?.updateState(CallState.callEnded);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.call_end_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
