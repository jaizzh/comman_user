import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoPath;
  const FullScreenVideoPlayer({required this.videoPath});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool isPortrait = true;

  @override
  void initState() {
    super.initState();
    // Start in portrait orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) => setState(() {}))
      ..play();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]); // Unlock orientation
    _controller.dispose();
    super.dispose();
  }

  void toggleOrientation() {
    setState(() {
      isPortrait = !isPortrait;
      SystemChrome.setPreferredOrientations([
        isPortrait
            ? DeviceOrientation.portraitUp
            : DeviceOrientation.landscapeLeft
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : CircularProgressIndicator(),
          ),
          // Controls
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              children: [
                VideoProgressIndicator(_controller, allowScrubbing: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                    ),
                    Text(
                      // Duration format min:sec
                      "${(_controller.value.position.inMinutes).toString().padLeft(2, '0')}:${(_controller.value.position.inSeconds % 60).toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(Icons.screen_rotation, color: Colors.white),
                      onPressed: toggleOrientation,
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
