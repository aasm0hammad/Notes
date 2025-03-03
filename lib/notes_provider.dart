import 'package:flutter/material.dart';
import 'package:notes_app/db_helper.dart';
import 'package:notes_app/note_model.dart';

class NotesProvider extends ChangeNotifier {

  DbHelper dbHelper;

  NotesProvider({required this.dbHelper});

  List<NoteModel> _mNotes = [];

  List<NoteModel> getAllNotes()=>_mNotes;

  addNote( NoteModel newnote) async{
 bool check=await dbHelper.addNote(newNote: newnote);

 if(check){
   _mNotes= await dbHelper.fetchAllNotes();
   notifyListeners();

 }

  }

  Future<void >updateNotes(NoteModel UpdateNote)async{

    bool check = await dbHelper.updateNote(UpdateNote);
    if(check){
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }


  }

  Future<void>delete(int id )async{

    bool check = await dbHelper.deleteNote(id);
    if(check){

      _mNotes= await dbHelper.fetchAllNotes();
      notifyListeners();
    }


  }

 getInitialNotes()async{
   _mNotes= await dbHelper.fetchAllNotes();
   notifyListeners();

 }


}