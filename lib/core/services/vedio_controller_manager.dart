import 'package:cached_video_player_plus/cached_video_player_plus.dart';

class VideoControllerManager {
  VideoControllerManager._();

  static final VideoControllerManager instance =
  VideoControllerManager._();

  final Map<String, CachedVideoPlayerPlus>
  _controllers = {};

  CachedVideoPlayerPlus? getController(
      String reelId,
      ) {
    return _controllers[reelId];
  }

  bool hasController(String reelId) {
    return _controllers.containsKey(reelId);
  }

  Future<void> initializeController({
    required String reelId,
    required String videoUrl,
  }) async {
    if (_controllers.containsKey(reelId)) {
      return;
    }

    final controller =
    CachedVideoPlayerPlus.networkUrl(
      Uri.parse(videoUrl),
    );

    await controller.initialize();

    controller.controller.setLooping(true);

    _controllers[reelId] = controller;
  }

  Future<void> play(String reelId) async {
    final controller = _controllers[reelId];

    if (controller == null) return;

    await controller.controller.play();
  }

  Future<void> pause(String reelId) async {
    final controller = _controllers[reelId];

    if (controller == null) return;

    await controller.controller.pause();
  }

  Future<void> disposeController(
      String reelId,
      ) async {
    final controller =
    _controllers.remove(reelId);

    await controller?.dispose();
  }

  Future<void> disposeAll() async {
    for (final controller
    in _controllers.values) {
      await controller.dispose();
    }

    _controllers.clear();
  }

  int get activeControllers =>
      _controllers.length;
}