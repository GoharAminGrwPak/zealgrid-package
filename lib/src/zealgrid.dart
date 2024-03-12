import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Zealgrid{
  static Zealgrid? _this;
  final String path;
  Zealgrid._({this.path=''});
  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  static Zealgrid getInstance({String path=''}){
    if(_this==null){
      _this = Zealgrid._(path: path);
    }
    return _this!;
  }
  Zealgrid child(String child) {
    return Zealgrid._(path: '$path/$child');
  }
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
  Future<String?> getString(String key)async{
    try {
      debugPrint('PATH : ${path}/${key}');
      DataSnapshot snapshot = await _database.child(path).child(key).get();
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
  Future<int?> getInt(String key)async{
    debugPrint('PATH : ${path}/${key}');

    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
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
  Future<bool?> getBool(String key)async{
    debugPrint('PATH : ${path}/${key}');

    try {
      DataSnapshot snapshot = await _database.child(path).child(key).get();
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
  Future<dynamic?> getObject(String key)async{
    try {
      debugPrint('PATH : ${path}/${key}');

      DataSnapshot snapshot = await _database.child(path).child(key).get();
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
  Future<List<dynamic>>getList(String key) async {
    try {
      debugPrint('PATH : ${path}/${key}');

      DataSnapshot snapshot = await _database.child(path).child(key).get();
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