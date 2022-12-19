import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String visitor = "";
  String id      = "";
  String note    = "";
  String date    = "";
  String hour    = "";
  

  bool isValidForm (){

    // print(formKey.currentState?.validate());
    // print("$visitor- $id- $note - $date - $hour");

    return formKey.currentState?.validate() ?? false;
  }


  Map<String, dynamic> message (){
    Map<String, dynamic> userMessage ={
      "visitor" : visitor,
      "id"      : id,
      "note"    : note,
      "date"    : date,
      "hour"    : hour,
      
    };

    return userMessage;
  }


}