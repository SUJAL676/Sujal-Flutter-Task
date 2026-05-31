import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseService {
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref();

  Future<DataSnapshot> getReels() async {
    return await _database.child('reels').get();
  }
}