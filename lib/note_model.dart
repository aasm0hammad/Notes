import 'db_helper.dart';

class NoteModel {
  int? nID;
  String nTitle;
  String nDesc;
  String nCreatedAT;

  NoteModel(
      {this.nID,
      required this.nTitle,
      required this.nDesc,
        required this.nCreatedAT,
      });

  Map<String,dynamic>  toMap(){

    return {

      DbHelper.COLUMN_NOTE_TITLE:nTitle,
      DbHelper.COLUMN_NOTE_DESC: nDesc,
      DbHelper.COLUMN_NOTE_CREATED_AT: nCreatedAT,

    };
  }

  factory NoteModel.fromMap(Map<String,dynamic>map){
    return NoteModel(
        nID: map[DbHelper.COLUMN_NOTE_ID],
        nTitle: map[DbHelper.COLUMN_NOTE_TITLE],
        nDesc: map[DbHelper.COLUMN_NOTE_DESC],
        nCreatedAT: map[DbHelper.COLUMN_NOTE_CREATED_AT],


    );

  }



}
