
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CallProvider extends ChangeNotifier {
  bool _oncall = false; // Correctly maintains state
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool get oncall => _oncall;

  void onThecall(bool value) {
    _oncall = value;

    if (_oncall) {
      DisposeMusic(); // Stop music when call is active
    } else {
      playMusic(); // Start music when call is inactive
    }

    notifyListeners(); // Notify UI about the state change
  }

  Future<void> playMusic() async {
    await _audioPlayer.play(AssetSource('Musics/realme.mp3'));
  }

  Future<void> DisposeMusic() async {
    await _audioPlayer.dispose();
  }
}
