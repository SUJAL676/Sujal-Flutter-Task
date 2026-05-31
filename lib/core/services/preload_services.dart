import 'package:flutter_task/core/services/vedio_controller_manager.dart';

import '../../features/reel/data/models/reel_model.dart';

class VideoPreloadService {
  VideoPreloadService._();

  static final instance = VideoPreloadService._();

  final VideoControllerManager _manager =
      VideoControllerManager.instance;

  static const int preloadCount = 3;

  Future<void> handlePageChanged({
    required int currentIndex,
    required List<ReelModel> reels,
  }) async {
    if (reels.isEmpty) return;

    await _initializeCurrent(
      currentIndex,
      reels,
    );

    await _preloadNextVideos(
      currentIndex,
      reels,
    );

    await _disposeUnusedVideos(
      currentIndex,
      reels,
    );
  }

  Future<void> _initializeCurrent(
      int currentIndex,
      List<ReelModel> reels,
      ) async {
    final reel = reels[currentIndex];

    if (!_manager.hasController(reel.id)) {
      await _manager.initializeController(
        reelId: reel.id,
        videoUrl: reel.videoUrl,
      );
    }
  }

  Future<void> _preloadNextVideos(
      int currentIndex,
      List<ReelModel> reels,
      ) async {
    for (
    int i = currentIndex + 1;
    i <= currentIndex + preloadCount;
    i++
    ) {
      if (i >= reels.length) {
        break;
      }

      final reel = reels[i];

      if (!_manager.hasController(reel.id)) {
        await _manager.initializeController(
          reelId: reel.id,
          videoUrl: reel.videoUrl,
        );
      }
    }
  }

  Future<void> _disposeUnusedVideos(
      int currentIndex,
      List<ReelModel> reels,
      ) async {
    for (int i = 0; i < reels.length; i++) {
      final reel = reels[i];

      final shouldKeep =
          i >= currentIndex - 1 &&
              i <= currentIndex + preloadCount;

      if (!shouldKeep) {
        await _manager.disposeController(
          reel.id,
        );
      }
    }
  }
}