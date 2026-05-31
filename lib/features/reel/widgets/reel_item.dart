import 'package:flutter/material.dart';
import 'package:flutter_task/features/reel/widgets/player.dart';
import '../../../core/services/vedio_controller_manager.dart';
import '../data/models/reel_model.dart';
import 'reel_overlay.dart';

class ReelItem extends StatelessWidget {
  final ReelModel reel;

  const ReelItem({
    super.key,
    required this.reel,
  });

  @override
  Widget build(BuildContext context) {
    final player =
    VideoControllerManager.instance
        .getController(reel.id);

    if (player == null || !player.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white,),
      );
    }

    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ReelVideoPlayer(
            player: player,
          ),
          ReelOverlay(
            reel: reel,
          ),
        ],
      ),
    );
  }
}