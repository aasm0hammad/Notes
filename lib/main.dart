import 'package:flutter/material.dart';
import 'package:notes_app/add_note.dart';
import 'package:notes_app/db_helper.dart';
import 'package:notes_app/details_note.dart';
import 'package:notes_app/notes_provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => NotesProvider(dbHelper: DbHelper.getInstance()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
