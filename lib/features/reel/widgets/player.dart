import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelVideoPlayer extends StatelessWidget {
  final CachedVideoPlayerPlus player;

  const ReelVideoPlayer({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    if (!player.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white,),
      );
    }

    final controller = player.controller;

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}