import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
///private Constructor
  DbHelper._();

  static DbHelper getInstance()=> DbHelper._();


  Database? _db;

Future<Database> getDB()async{
  _db ??= await openDB();
  return _db!;

}

  Future<Database> openDB() async{

    Directory appDocDir= await getApplicationDocumentsDirectory();

    String dbPath= join(appDocDir.path,"noteBD.db");

    return await openDatabase(dbPath,onCreate: (db,version){
      ///create tables
      
      db.execute("create table notes ( nId Integer primary key auto increment , nTitle text, NDesc text, nCreatedAt text   )");

    });
  }

  void insertNote({ required String title, required String desc})async{

  var db = await getDB();


  }


}