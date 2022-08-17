import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  late AudioPlayer player;

  AudioPlayerService() {
    player = AudioPlayer();
  }

  /// play the sound with the soundName of .wav extension
  play(String soundName) {
    try {
      player.play(AssetSource('sounds/$soundName.wav'));
    } catch (_) {
      player.play(AssetSource('sounds/1.wav'));
    }
  }
}
