import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnail extends StatefulWidget {
  final String videoPath;
  const VideoThumbnail({super.key, required this.videoPath});

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              const Icon(Icons.play_circle_fill, color: Colors.white, size: 36),
            ],
          )
        : Container(color: Colors.black12);
  }
}
