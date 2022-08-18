import 'package:audioplayers/audioplayers.dart';
import 'package:pomodoro/src/constants/constants.dart';

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
      player.play(AssetSource('sounds/${alarmSoundNames[0]}.wav'));
    }
  }
}
