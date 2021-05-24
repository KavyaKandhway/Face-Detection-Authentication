import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DataBaseService {
  // singleton boilerplate
  static final DataBaseService _cameraServiceService =
      DataBaseService._internal();

  factory DataBaseService() {
    return _cameraServiceService;
  }
  // singleton boilerplate
  DataBaseService._internal();

  /// file that stores the data on filesystem
  File jsonFile;

  /// Data learned on memory
  Map<String, dynamic> _db = Map<String, dynamic>();
  Map<String, dynamic> get db => this._db;

  /// loads a simple json file.
  Future loadDB() async {
    var tempDir = await getApplicationDocumentsDirectory();
    String _embPath = tempDir.path + '/emb.json';

    jsonFile = new File(_embPath);

    if (jsonFile.existsSync()) {
      _db = json.decode(jsonFile.readAsStringSync());
    }
  }

  Future saveData(String user, String password, List modelData) async {
    String userAndPass = user + ':' + password;
    _db[userAndPass] = modelData;
    jsonFile.writeAsStringSync(json.encode(_db));
  }

  /// deletes the created users
  cleanDB() {
    this._db = Map<String, dynamic>();
    jsonFile.writeAsStringSync(json.encode({}));
  }
}
//
// class CloudService {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   CollectionReference faces = FirebaseFirestore.instance.collection('face');
//   Future<void> saveData(String name, String password, List<dynamic> output) {
//     List<Map> mapOutput = [];
//     output.forEach((dynamic output) {
//       Map out = output.toMap();
//       mapOutput.add(out);
//     });
//
//     // Call the user's CollectionReference to add a new user
//     return faces
//         .add({
//           'name': name, // John Doe
//           'output': mapOutput, // Stokes and Sons
//           'password': password // 42
//         })
//         .then((value) => print("User Added"))
//         .catchError((error) => print("Failed to add user: $error"));
//   }
//
//   Future<List> listAllUser() async {
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection("collection").get();
//     var list = querySnapshot.docs;
//     print("size of data");
//     print(list.length);
//     return list;
//   }
// }
