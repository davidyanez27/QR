import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_form_provider.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            const Background(ColorBubble1: Color.fromARGB(224, 96, 156, 70), ColorBubble2: Color.fromARGB(223, 70, 156, 80)),
            ChangeNotifierProvider(
              create: (_)=> LoginFormProvider(),
            child: LoginForm(
              title:"Register",
              size: size, 
              route: 'login', 
              text: 'Register',  
              onPressedRoute: 'login',
            ),
            )
          ],
         ),
        ),
      ),
    );
  }
}

//  () {
//                 const url = 'https:youtube.com';
//                 Uri uri = Uri.parse(url);
//                 launchUrl(uri); 
//                }