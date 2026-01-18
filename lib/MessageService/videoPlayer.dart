import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

// ignore: must_be_immutable
class VideoPage extends StatefulWidget {
  late String urlVideo;
  VideoPage({super.key, required this.urlVideo});

  @override
  State<VideoPage> createState() => _VideoPage(urlVideo: urlVideo);
}

class _VideoPage extends State<VideoPage> {
  late String urlVideo;

  _VideoPage({required this.urlVideo});

  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    player.open(Media(urlVideo));
    player.pause();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Video(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          controller: controller),
    );
  }
}