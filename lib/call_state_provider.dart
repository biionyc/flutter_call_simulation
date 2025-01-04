import 'package:flutter/material.dart';

enum CallState { idle, ringing, inCall, callEnded }

class CallStateProvider extends ChangeNotifier {
  CallState _state = CallState.idle;

  CallState get state => _state;

  void updateState(CallState newState) {
    _state = newState;
    notifyListeners();
  }
}
