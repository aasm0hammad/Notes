import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper? mDb;
  List<Map<String,dynamic>> mData =[];

  @override
  void initState() {
    super.initState();
    mDb= DbHelper.getInstance();
    getAllNotes();

  }
  void getAllNotes()async{

    mData=await mDb!.fetchAllNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mData.isNotEmpty ? ListView.builder(
          itemCount: mData.length,
          itemBuilder: (_,index){
            return ListTile(
              title: Text(mData[index][DbHelper.COLUMN_NOTE_TITLE]),
              subtitle: Text(mData[index][DbHelper.COLUMN_NOTE_DESC]),
            );

      }): Center(child: Text("No Notes?"),),
      floatingActionButton: FloatingActionButton(onPressed: ()async {
        bool check =await mDb!.addNote(title: "Today", desc: "Done");
        if(check){
          print("note add");
          getAllNotes();
        }

      },child: Icon(Icons.add),),
    );
  }
}
