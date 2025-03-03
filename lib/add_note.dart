import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/notes_provider.dart';
import 'package:provider/provider.dart';

import 'db_helper.dart';
import 'note_model.dart';

class AddNote extends StatefulWidget {

  bool isUpdate=false;
  int index=-1;
  String title='';
  String desc='';
  String createdAt='';


  AddNote({this.isUpdate=false,this.index=-1, this.title='',this.desc='' ,this.createdAt='',});
  @override
  State<StatefulWidget> createState() => AddNoteState();

}

class AddNoteState extends State<AddNote> {


  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DateFormat df =DateFormat.yMMMEd();


  @override
  Widget build(BuildContext context) {
    var mData=context.read<NotesProvider>().getAllNotes();
    if(widget.isUpdate){
      titleController.text= widget.title;
      descController.text= widget.desc;
     // String titleText=Text('Update Notes');
    }

    return Scaffold(
      appBar: AppBar(
        title: widget.isUpdate ?Text("Update Note"): Text("Add Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(11),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        // width: double.infinity,
        child: Column(
          children: [
            widget.isUpdate ? Text(
              "Update Note",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ):
            Text(
              "Add Note",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter Title",
                label: Text("Title"),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                label: Text("Desc"),
                hintText: "Enter Desc",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if(widget.isUpdate){
                        context.read<NotesProvider>().updateNotes(NoteModel(
                            nID:widget.index,nTitle: titleController.text, nDesc: descController.text, nCreatedAT: widget.createdAt ));
                      }else{
                      context.read<NotesProvider>().addNote(NoteModel(
                              nTitle: titleController.text,
                              nDesc: descController.text,
                              nCreatedAT: DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString()));

                      }
                      Navigator.pop(context);

                    },
                    child: widget.isUpdate ?Text("Update"): Text("ADD")),
                SizedBox(
                  width: 11,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
