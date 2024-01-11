import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<void> addBuildingRecord(String buildingName, String damageLevel,
      List<Map<String, double>> buildingPoints) async {
    try {
      // Firebase'e yeni kaydı ekleyin
      await _database.child('buildings').push().set({
        'name': buildingName,
        'damageLevel': damageLevel,
        'points': buildingPoints,
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getBuildingRecords() async {
    try {
      // Firebase'den kayıtları çekin
      DataSnapshot snapshot = await _database.child('buildings').once();
      List<Map<String, dynamic>> records = [];

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, value) {
          records.add({
            'key': key,
            'name': value['name'],
            'damageLevel': value['damageLevel'],
            'points': value['points'],
          });
        });
      }

      return records;
    } catch (e) {
      print('Hata: $e');
      return [];
    }
  }
}
