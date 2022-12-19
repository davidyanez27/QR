import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/screens.dart';
import '../services/services.dart';

class LoadingScreen extends StatelessWidget {

  // ignore: prefer_typing_uninitialized_variables
  final userEmail; 
  const LoadingScreen(
    {Key? key,
    this.userEmail}) 
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
          
    //take the all data (name, email, direction, rol) for the user
    Map <String, dynamic> user={};
    for (var element in userService.users) { 
      if (element.email == userEmail){
        user = element.toMap();
        }
      } 

    return userService.users.isEmpty? const _loadingWidget(): showScreen(user);

  }

  StatelessWidget showScreen(Map<String, dynamic> user) {
  return (user["rol"]=="user"? const UserScreen(): 
          user["rol"]=="guard"? const GuardScreen(): const LoginScreen());
  }
}


// ignore: camel_case_types
class _loadingWidget extends StatelessWidget {
  const _loadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
         child: CircularProgressIndicator(
          color: Colors.indigo,
         ),
      ),
    );
  }
}