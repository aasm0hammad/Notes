import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  ///private Constructor
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  static const String TABLE_NOTE = "notes";
  static const String COLUMN_NOTE_ID = "nID";
  static const String COLUMN_NOTE_TITLE = "nTitle";
  static const String COLUMN_NOTE_DESC = "nDesc";
  static const String COLUMN_NOTE_CREATED_AT = "nCreatedAT";

  Database? _db;

  Future<Database> getDB() async {
    _db ??= await openDB();
    return _db!;
  }

  Future<Database> openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDocDir.path, "noteBD.db");

    return await openDatabase(dbPath,version: 1, onCreate: (db, version) {
      ///create tables

      db.execute(
          "create table $TABLE_NOTE ( $COLUMN_NOTE_ID Integer primary key autoincrement , $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text, $COLUMN_NOTE_CREATED_AT text   )");
    });
  }

  Future<bool> addNote({required String title, required String desc}) async {
    Database db = await getDB();

    int rowEffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: title,
      COLUMN_NOTE_DESC: desc,
      COLUMN_NOTE_CREATED_AT: DateTime.now().microsecondsSinceEpoch.toString(),
    });
    return rowEffected>0;
  }

  Future<List<Map<String,dynamic>>> fetchAllNotes() async{

    var db= await getDB();

    List<Map<String,dynamic>> mNotes= await db.query(TABLE_NOTE);
    return mNotes;

  }

}
