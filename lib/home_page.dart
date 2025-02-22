import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController =TextEditingController();
  TextEditingController descController =TextEditingController();
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
        titleController.clear();
        descController.clear();
       showModalBottomSheet(context: context, builder: (_){
        return Container(
          padding: EdgeInsets.all(11),
          color: Colors.white,
          width: double.infinity,
          height: 400,
         // width: double.infinity,
          child: Column(
            children: [
              Text("Add Note",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
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
                  ElevatedButton(onPressed: ()async{
                  bool check=await mDb!.addNote(title: titleController.text, desc: descController.text);
                  Navigator.pop(context);

                  if(check){
                    getAllNotes();
                  }

                  }, child: Text("ADD")),
                  SizedBox(
                    width: 11,
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);

                  }, child: Text("Cancel")),
                ],
              )
            ],
          ),
        );
      });

       /* if(check){
          print("note add");
          getAllNotes();
        }*/

      },child: Icon(Icons.add),),
    );
  }
}
