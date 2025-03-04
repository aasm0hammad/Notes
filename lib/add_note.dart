import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/details_note.dart';
import 'package:notes_app/home_page.dart';
import 'package:notes_app/notes_provider.dart';
import 'package:provider/provider.dart';

import 'db_helper.dart';
import 'note_model.dart';

class AddNote extends StatefulWidget {
  bool isUpdate = false;
  int id = -1;
  String title = '';
  String desc = '';
  String createdAt = '';

  AddNote({
    this.isUpdate = false,
    this.id = -1,
    this.title = '',
    this.desc = '',
    this.createdAt = '',
  });

  @override
  State<StatefulWidget> createState() => AddNoteState();
}

class AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DateFormat df = DateFormat.yMMMEd();

  @override
  Widget build(BuildContext context) {
    var mData = context.read<NotesProvider>().getAllNotes();

    if (widget.isUpdate) {
      titleController.text = widget.title;
      descController.text = widget.desc;
      // String titleText=Text('Update Notes');
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: widget.isUpdate ? Text("Update Note") : Text("Add Note"),
        backgroundColor: Colors.black,
        leading: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty) {
                  if (widget.isUpdate) {
                    await context.read<NotesProvider>().updateNotes(
                          NoteModel(
                              nID: widget.id,
                              nTitle: titleController.text,
                              nDesc: descController.text,
                              nCreatedAT: widget.createdAt),
                        );

                    Navigator.pop(context);
                  } else {
                    context.read<NotesProvider>().addNote(NoteModel(
                        nTitle: titleController.text,
                        nDesc: titleController.text,
                        nCreatedAT:
                            DateTime.now().microsecondsSinceEpoch.toString()));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                } else {}
              },
              child: widget.isUpdate
                  ? Text("Update",
                      style: TextStyle(
                        color: Colors.white,
                      ))
                  : Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey.shade500),
              ),
              /*maxLines: 3,
              overflow: TextOverflow.fade,*/
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: descController,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Type something...",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    border: InputBorder.none,
                  ),
                  style:
                      TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
