import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  late AudioPlayer player;

  AudioPlayerService() {
    player = AudioPlayer();
  }

  play() => player.play(AssetSource('sounds/1.wav'));
}
