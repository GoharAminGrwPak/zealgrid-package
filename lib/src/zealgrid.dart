import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Zealgrid{
  static Zealgrid? _this;
  final String url;
  Zealgrid._({required this.url});
  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  static Zealgrid getInstance({
    required String url
  }){
    if(_this==null){
      _this = Zealgrid._(url: url);
    }
    return _this!;
  }
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
  static Future<String?> getString(String key)async{
    try {
      DataSnapshot snapshot = await _database.child(key).get();
      if (snapshot.value != null) {
        return snapshot.value.toString();
      } else {
        return null; // Return null if the key doesn't exist or has no value
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null in case of any error
    }
  }
  static Future<int?> getInt(String key)async{
    try {
      DataSnapshot snapshot = await _database.child(key).get();
      if (snapshot.value != null) {
        return int.tryParse('${snapshot.value}');
      } else {
        return null; // Return null if the key doesn't exist or has no value
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null in case of any error
    }
  }
  static Future<bool?> getBool(String key)async{
    try {
      DataSnapshot snapshot = await _database.child(key).get();
      if (snapshot.value != null) {
        return bool.tryParse('${snapshot.value}');
      } else {
        return null; // Return null if the key doesn't exist or has no value
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null in case of any error
    }
  }
  static Future<dynamic?> getObject(String key)async{
    try {
      DataSnapshot snapshot = await _database.child(key).get();
      if (snapshot.value != null) {
        return snapshot.value;
      } else {
        return null; // Return null if the key doesn't exist or has no value
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null in case of any error
    }
  }
  static Future<List<dynamic>> getList(String key) async {
    try {
      DataSnapshot snapshot = await _database.child(key).get();
      if (snapshot.value != null && snapshot.value is Iterable) {
        return List.from(snapshot.value as Iterable);
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return an empty list in case of any error
    }
  }
}