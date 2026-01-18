import 'package:audioplayers/audioplayers.dart';

class PlayerAudio
{
  final player = AudioPlayer();

  playNotification()async
  {
    await player.setSource(AssetSource('notification.wav'));
    await player.resume();
  }

  playCall()async
  {
    await player.setSource(AssetSource('call.wav'));
    await player.resume();
  }

  playWebSound(String urlAudio)async
  {
    await player.play(UrlSource(urlAudio, mimeType: 'audio/wav'));
    await player.resume();
  }
  stop()
  {
    player.stop();
  }
}
