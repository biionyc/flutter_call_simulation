import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RingtoneManager {
  AudioPlayer? _player;
  Timer? _timer;

  void startRinging({VoidCallback? onStopRinging}) async {
    _player = AudioPlayer();
    await _player!.setAsset('assets/ringtone.mp3');
    _player!.setLoopMode(LoopMode.one);
    _player!.play();

    _timer = Timer(
      const Duration(seconds: 30),
      () {
        stopRinging();
        if (onStopRinging != null) {
          onStopRinging();
        }
      },
    );
  }

  void stopRinging() {
    _player?.stop();
    _player?.dispose();
    _player = null;

    _timer?.cancel();
    _timer = null;
  }
}
