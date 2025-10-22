import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerPage extends StatelessWidget {
  final YoutubePlayerController controller;

  const YoutubeVideoPlayerPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.metadata.title.isEmpty
            ? "YouTube Video"
            : controller.metadata.title),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
