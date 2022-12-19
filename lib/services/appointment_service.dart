import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class AppointmentService extends ChangeNotifier{
  final String _baseUrl = "login-12df1-default-rtdb.firebaseio.com";
  final String _firebaseToken = "AIzaSyApGkeDOwWwMkHGGHL-suZu8Ai5TPnEzcw";

  bool isLoading = true;
  final List<Visitor> citas=[];  
  final List<Visitor> visit = [];
  final storage = FlutterSecureStorage();

Future<String?> createAppointment( Map appointmentData) async {
  print(appointmentData);
    final url = Uri.https(_baseUrl, "citas.json",{
      'auth':await storage.read(key: "token")?? ""
    });
    final resp = await http.post(url, body: json.encode(appointmentData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    


    return decodeResp["name"].toString();
  }



  AppointmentService(){
    getAppointments();

  }

  
  Future<List<Visitor>> getAppointments() async{
    
    isLoading = true;
    notifyListeners();

    //keep the .json for the fetch
    final url = Uri.https(_baseUrl, "citas.json",{
      'auth':await storage.read(key: "token")?? ""
    });

    //this give a Instance of Response 
    final resp = await http.get( url );

    final Map<String, dynamic> appointmentMap = json.decode(resp.body);

    visit.clear();
    appointmentMap.forEach((key, value) {
      var appointment = Visitor.fromMap(value);
      appointment.id = key;
      visit.add(appointment);
    
    });
      print(visit.length);

    isLoading = false;
    notifyListeners();
    print(visit[0].toMap());

    return visit;
  }


               // dynamic appointmenst= await appointmentService.getAppointments();
                    // for (var element in appointmenst) { 
                    //   //print(element.toMap());
                    //   if (element.date == DateTime.now().toString()){
                    //     citas.add(element.toMap());
                    //     }
                    //   }
                    //   print(citas); 





}