import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ReelCacheManager {
  static CacheManager instance = CacheManager(
    Config(
      'reels_cache',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 50,
    ),
  );
}