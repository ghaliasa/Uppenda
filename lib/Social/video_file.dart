import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget2 extends StatefulWidget {
  var video;
  VideoPlayerWidget2(var video) {
    this.video = video;
  }

  @override
  _VideoPlayerWidget2State createState() => _VideoPlayerWidget2State();
}

class _VideoPlayerWidget2State extends State<VideoPlayerWidget2> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = widget.video != null
        ? widget.video is File
            ? VideoPlayerController.file(widget.video)
            : VideoPlayerController.asset(widget.video)
        : null;
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      child: Stack(
        key: Key(
          widget.video.toString(),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: 200.0,
              width: 200.0,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140, left: 0),
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.purple,
              onPressed: () {
                setState(
                  () {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  },
                );
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
