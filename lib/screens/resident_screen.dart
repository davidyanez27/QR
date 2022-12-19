import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';

class ResidentScreen extends StatefulWidget {
   
  const ResidentScreen({Key? key}) : super(key: key);

  @override
  State<ResidentScreen> createState() => _ResidentScreenState();
}

class _ResidentScreenState extends State<ResidentScreen> {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);
    
    //Aqui se adquiere el nombre
    List<String> users=[];
    for (var element in userService.users) { 
        users.add(element.nombre+ " " + element.apellido);
      } 
    
    //Aqui se adquiere la direccion
    List<String> direction=[];
    for (var element in userService.users) { 
        direction.add(element.direccion);
      }
    
    return Scaffold(
      body: Center(
         child: ListView.builder(itemCount:userService.users.length, itemBuilder: (BuildContext context, int index){return Cards(visitor: users[index], fecha: direction[index]);
         
         }),
      ),
    );
  }
}