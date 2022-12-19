import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../screens/screens.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class UserScreen extends StatelessWidget {


  const UserScreen({super.key});
     
  @override
  Widget build(BuildContext context) {

    //call the data when the user pass the login
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendario"),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          authService.logout();
          Navigator.pushReplacementNamed(context, "checking");
        }, icon: const Icon(Icons.login_outlined)),
      ),
      
      //Aqui se dibuja el calendario
      body: const CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          final appointment = PageRouteBuilder(pageBuilder: ((context, __, ___) => ChangeNotifierProvider(create: (context)=>AppointmentProvider(), child: const Appointment1())));

          final route = MaterialPageRoute(builder: (context) => const Appointment1());
          Navigator.of(context).push(appointment);
        }
        )
    );
  }
}