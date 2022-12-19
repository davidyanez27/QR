import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:residentes/screens/screens.dart';
import 'package:residentes/services/services.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

              if (!snapshot.hasData) {
                Future.microtask(() {
                  Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___)=>const LoginScreen(), transitionDuration: const Duration(seconds: 0)));
              });
              }else{
                Future.microtask(() {
                  Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___)=>UserScreen(), transitionDuration: const Duration(seconds: 0)));
              });
              }
              return Container();


            }),
      ),
    );
  }
}
