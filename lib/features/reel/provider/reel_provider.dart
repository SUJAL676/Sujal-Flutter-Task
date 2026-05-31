import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/preload_services.dart';
import '../../../core/services/vedio_controller_manager.dart';
import '../data/models/reel_model.dart';
import '../data/repo/reel_repo.dart';

class ReelProvider extends ChangeNotifier {
  final ReelRepository repository;

  ReelProvider(this.repository){
    loadUserActions();
  }

  bool _isAppReady = false;

  bool get isAppReady => _isAppReady;

  bool _isLoading = false;

  List<ReelModel> _reels = [];

  int _currentIndex = 0;

  bool get isLoading => _isLoading;

  List<ReelModel> get reels => _reels;

  int get currentIndex => _currentIndex;

  final Set<String> _likedReels = {};

  final Set<String> _bookmarkedReels = {};

  Set<String> get likedReels => _likedReels;

  Set<String> get bookmarkedReels => _bookmarkedReels;

  Future<void> loadUserActions() async {
    final prefs =
    await SharedPreferences.getInstance();

    _likedReels.addAll(
      prefs.getStringList('liked_reels') ?? [],
    );

    _bookmarkedReels.addAll(
      prefs.getStringList(
        'bookmarked_reels',
      ) ??
          [],
    );

    notifyListeners();
  }

  Future<void> toggleBookmark(
      String reelId,
      ) async {
    final prefs =
    await SharedPreferences.getInstance();

    if (_bookmarkedReels.contains(reelId)) {
      _bookmarkedReels.remove(reelId);
    } else {
      _bookmarkedReels.add(reelId);
    }

    await prefs.setStringList(
      'bookmarked_reels',
      _bookmarkedReels.toList(),
    );

    notifyListeners();
  }

  Future<void> toggleLike(
      String reelId,
      ) async {
    final prefs =
    await SharedPreferences.getInstance();

    if (_likedReels.contains(reelId)) {
      _likedReels.remove(reelId);
    } else {
      _likedReels.add(reelId);
    }

    await prefs.setStringList(
      'liked_reels',
      _likedReels.toList(),
    );

    notifyListeners();
  }

  Future<void> fetchReels() async {
    try {
      _isLoading = true;
      notifyListeners();

      _reels = await repository.fetchReels();

      if (_reels.isNotEmpty) {
        await VideoPreloadService.instance.handlePageChanged(
          currentIndex: 0,
          reels: _reels,
        );

        await VideoControllerManager.instance.play(
          _reels[0].id,
        );
      }

      _isAppReady = true;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      _isAppReady = true;
      notifyListeners();
    }
  }

  Future<void> onPageChanged(int index) async {
    if (index == _currentIndex) {
      return;
    }

    final previousIndex = _currentIndex;

    _currentIndex = index;

    if (previousIndex < _reels.length) {
      await VideoControllerManager.instance.pause(
        _reels[previousIndex].id,
      );
    }

    await VideoPreloadService.instance
        .handlePageChanged(
      currentIndex: index,
      reels: _reels,
    );

    await VideoControllerManager.instance.play(
      _reels[index].id,
    );

    notifyListeners();
  }

  @override
  void dispose() {
    VideoControllerManager.instance.disposeAll();
    super.dispose();
  }
}