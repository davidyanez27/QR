import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:residentes/providers/login_form_provider.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            const Background(ColorBubble1: Color.fromARGB(226, 80, 70, 156), ColorBubble2: Color.fromRGBO(90, 70, 178, 1)), 
            ChangeNotifierProvider(
              create: (_)=> LoginFormProvider(),
              child:  LoginForm(
                title:"Login",
                size: size, 
                route: 'register', 
                text: 'Login', 
                onPressedRoute: "user", 
              ),
           ),
          
          ],
         ),
        ),
      ),
    );
  }
}





