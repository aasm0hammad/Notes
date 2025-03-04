import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/add_note.dart';
import 'package:notes_app/home_page.dart';
import 'package:notes_app/notes_provider.dart';
import 'package:provider/provider.dart';

class DetailsNote extends StatefulWidget {

  String title='';
  String desc='';
  String createdAt='';
  int? id=-1;
  DetailsNote({ this.id=-1});

  @override
  State<DetailsNote> createState() => _DetailsNoteState();

}


class _DetailsNoteState extends State<DetailsNote> {
  @override
  Widget build(BuildContext context) {

     var mData=  context.watch<NotesProvider>().getNoteById(widget.id!);


     var eachDate=DateTime.fromMicrosecondsSinceEpoch(int.parse(mData.nCreatedAT));
     DateFormat db=DateFormat.yMMMEd();

     //mData.length
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        title: Text("Note Details",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,

        leading: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius
              .circular(8),
          ),
          child: IconButton(onPressed: () {
            Navigator.pop(context);

          }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),

            ),
            child: IconButton(onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>AddNote(
                isUpdate: true,
                title: mData.nTitle,
                desc: mData.nDesc,
                createdAt: mData.nCreatedAT,
                id: mData.nID!,

              )));

            },
                icon: Icon(Icons.edit_note, color: Colors.white,)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(mData.nTitle,
              maxLines: 3,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,

              ),),
            SizedBox(
              height: 11,
            ),
            Text(db.format(eachDate),
              style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,

            ),),
            SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                child: Text(mData.nDesc,style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5

                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}