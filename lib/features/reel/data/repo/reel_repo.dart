import '../../../../core/services/firebase_service.dart';
import '../models/reel_model.dart';

class ReelRepository {
  final RealtimeDatabaseService service;

  ReelRepository(this.service);

  Future<List<ReelModel>> fetchReels() async {
    final snapshot = await service.getReels();

    if (!snapshot.exists) {
      return [];
    }

    final data =
    snapshot.value as Map<dynamic, dynamic>;

    return data.entries.map((entry) {
      return ReelModel.fromMap(
        entry.key.toString(),
        entry.value,
      );
    }).toList();
  }
}