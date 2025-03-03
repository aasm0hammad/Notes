import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/add_note.dart';
import 'package:notes_app/db_helper.dart';
import 'package:notes_app/note_model.dart';
import 'package:notes_app/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController =TextEditingController();
  TextEditingController descController =TextEditingController();

  DateFormat df =DateFormat.yMMMEd();
var randomColor =Colors.primaries[Random().nextInt(Colors.primaries.length-1)];
  @override
  void initState() {
    super.initState();
    context.read<NotesProvider>().getInitialNotes();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.black,
        title: Text("Notes App", style: TextStyle(color: Colors.white),),),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NotesProvider>(builder: (_,provider,__){

          var mData=provider.getAllNotes();

          return GridView.builder(


              itemCount: provider.getAllNotes().length,



              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

              ),
              itemBuilder: (_,index){
                var eachdate= DateTime.fromMicrosecondsSinceEpoch(int.parse(mData[index].nCreatedAT));
                 return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onLongPress: (){
                      provider.delete(provider.getAllNotes()[index].nID!);
                    },
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote(
                        isUpdate: true,
                        index: provider.getAllNotes()[index].nID!,
                        title: provider.getAllNotes()[index].nTitle,
                        desc: provider.getAllNotes()[index].nDesc,
                        createdAt: provider.getAllNotes()[index].nCreatedAT,

                       )));
                      /*showModalBottomSheet(context: context, builder: (_){
                        titleController.text= mData[index].nTitle;
                        descController.clear();
                        return Container(
                          child: Column(
                            children: [

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
                              ElevatedButton(onPressed: ()async{
                               context.read<NotesProvider>().updateNotes(
                                   NoteModel(
                                     nID: mData[index].nID,
                                       nTitle: titleController.text,
                                       nDesc: descController.text,
                                       nCreatedAT: mData[index].nCreatedAT,
                                   ));

                                *//*bool check=await mDb!.updateNote(NoteModel(
                                    nTitle: titleController.text,
                                    nDesc: descController.text,
                                    nCreatedAT: mData[index].nCreatedAT,
                                    nID:mData[index].nID
                                ));*//*


                                Navigator.pop(context);
                              }, child: Text("Update")),
                            ],
                          ),
                        );

                      });*/
                    },
                    child: Container(
                        height: 200,
                        width: 200,
                        // padding: EdgeInsets.all(1),

                        decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.circular(11),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(child: Text(mData[index].nTitle,
                                maxLines:3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),)),
                              Text(mData[index].nDesc,style: TextStyle(fontSize: 21),),

                              Text(df.format(eachdate)),
                            ],
                          ),
                        )),
                  ),
                );


              });
        }),
      ),

      /*mData.isNotEmpty ? ListView.builder(
          itemCount: mData.length,
          itemBuilder: (_,index){
            var eachDate=DateTime.fromMicrosecondsSinceEpoch(int.parse(mData[index].nCreatedAT));
            return ListTile(
              title: Text(mData[index].nTitle),
              subtitle: Text(mData[index].nDesc),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: ()async{
                    showModalBottomSheet(context: context, builder: (_){
                      titleController.clear();
                      descController.clear();
                      return Container(
                        child: Column(
                          children: [

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
                            ElevatedButton(onPressed: ()async{

                             bool check=await mDb!.updateNote(NoteModel(
                                  nTitle: titleController.text,
                                  nDesc: descController.text,
                                  nCreatedAT: mData[index].nCreatedAT,
                                nID:mData[index].nID
                              ));

                             if(check){
                               getAllNotes();
                             }
                             Navigator.pop(context);
                            }, child: Text("Update")),
                          ],
                        ),
                      );

                    });

                  }, icon: Icon(
                      Icons.edit
                  )),
                  IconButton(onPressed: ()async{
                  bool  check=await mDb!.deleteNote(mData[index].nID!);

                  if(check){
                    getAllNotes();
                  }

                  }, icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
                ],
              ),
            );

      }): Center(child: Text("No Notes?"),),
      */
      floatingActionButton: FloatingActionButton(onPressed: ()async {
       Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNote()));




      },child: Icon(Icons.add),),
    );
  }
}
