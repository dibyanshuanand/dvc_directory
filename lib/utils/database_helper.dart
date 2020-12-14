import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static void anotherInitialize() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, "work_database.db");
    print('$path');

    var exists = await databaseExists(path);

    if (!exists) {
      print('Creating new copy from asset');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch(_) {}

      ByteData data = await rootBundle.load(join("assets", "database.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await new File(path).writeAsBytes(bytes, flush: true);
    } else {
      print ('Opening existing database');
    }

    var db = await openDatabase(path);
  }

  static Future<List<Map<String, dynamic>>> initializeDatabase(String queryInput) async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "database.db");

    if(FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load("assets/database.db");
      writeToFile(data, dbPath);
    }

    var departuresDatabase = await openDatabase(dbPath);
//    return departuresDatabase;

    var result = departuresDatabase.rawQuery(queryInput);
    return result;
  }

  static void writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytesSync(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}