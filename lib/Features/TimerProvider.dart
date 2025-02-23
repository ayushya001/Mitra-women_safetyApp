import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  Timer? _timer;

  // Getters to access time values
  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;

  // Start the timer
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;

      if (_seconds == 60) {
        _seconds = 0;
        _minutes++;

        if (_minutes == 60) {
          _minutes = 0;
          _hours++;
        }
      }

      notifyListeners(); // Update UI
    });
  }

  // Stop the timer
  void stopTimer() {
    _timer?.cancel();
    notifyListeners();
  }

  // Reset the timer
  void resetTimer() {
    _timer?.cancel();
    _seconds = 0;
    _minutes = 0;
    _hours = 0;
    notifyListeners();
  }
}
