import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:residentes/models/appointment_model.dart';
import 'package:residentes/widgets/card.dart';

import '../services/services.dart';

class HistoryScreen extends StatelessWidget {
   
  const HistoryScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final appointmentService = Provider.of<AppointmentService>(context);
   
    //Aqui se convierten las citas a mapa para luego mostrarlo
    List<Map<String,dynamic>> appointment=[];
    for (var element in appointmentService.visit) {
            appointment.add(element.toMap());
           
          } 
    print(appointment);


    return Scaffold(
      body: Center(
         child: ListView.builder(itemCount: appointment.length, itemBuilder: (BuildContext context, int index){return Cards(visitor: appointment[index]["visitor"], fecha: appointment[index]["date"]);}),
      ),
    );
  }
}


               // dynamic appointmenst= await appointmentService.getAppointments();
                    // for (var element in appointmenst) { 
                    //   //print(element.toMap());
                    //   if (element.date == DateTime.now().toString()){
                    //     citas.add(element.toMap());
                    //     }
                    //   }
                    //   print(citas); 


              // Positioned(
              //   top: _sliderEnable?400:310,
              //   left: 20,
              //   child: Container(
              //     color: Colors.red,
              //     height: 400,
              //     width: size.width*0.9,

              //     child: ListView.builder(
              //       itemCount: appointmentService.visit.length,
              //       itemBuilder: (BuildContext context, int index){
              //         return Cards(fecha: '', visitor: '',);
              //       }
                    
              //       ),
              //     )
                  
              // )