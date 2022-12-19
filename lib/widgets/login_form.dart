import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:residentes/providers/login_form_provider.dart';
import 'package:residentes/screens/loading_screen.dart';
import 'package:residentes/services/services.dart';


import '../themes/appTheme.dart';
import 'widgets.dart';

class LoginForm extends StatelessWidget {
  final String onPressedRoute;
  final String route;
  final Size size;
  final String text;
  final String title;
  

  const LoginForm({
    Key? key,
    required this.onPressedRoute,
    required this.route, 
    required this.size,
    required this.title, 
    required this.text, 
 
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Map <String, dynamic> user={};

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      width: size.width * 0.8,
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: EdgeInsets.only(left: size.width*0.3),
            child: Text(title, style: const TextStyle(fontSize: 50),),
          ),
          const SizedBox(height: 50),
      
          //for the email
          CustomTextField(
            BorderSide: const OutlineInputBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(60))),
            focusedBorder: const OutlineInputBorder(
                      borderSide  : BorderSide(color: AppTheme.primary), 
                      borderRadius: BorderRadius.only(topRight: Radius.circular(60))),
            hintText: 'Email',
            prefixIcon: Icons.alternate_email_outlined,
            onChange: (value){loginForm.email = value;},
            validator: (value) {
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);
      
               return regExp.hasMatch(value ?? '')? null : "invalid email";
              }
            
          ),
      
          //for the password
          CustomTextField(
            BorderSide: const OutlineInputBorder(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(60))),
            focusedBorder: const OutlineInputBorder(
                      borderSide  : BorderSide(color: AppTheme.primary), 
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(60))),
            hintText: 'Password',
            obscureText: true,
            prefixIcon: Icons.lock,
            onChange: (value){loginForm.password = value;},
            validator: (value) =>value!=null && value.length>=6? null : "minimum of 6 characters",
            
          ),
      
          const SizedBox(height: 50),
      
          CustomButton(
            buttonChild: Text(text, style: const TextStyle(color: Colors.white, fontSize: 15)),
            text: text, 
            onPressed: () async {
              //hide the keyboard and call the AthService
              FocusManager.instance.primaryFocus?.unfocus();
              final authService = Provider.of<AuthService>(context, listen: false);


              //show the login is the email or password is incorrect
              if (!loginForm.isValidForm()) return;
              loginForm.isLoading = true;

              //Login the user
              if (text == "Login"){
                final String? errorMessage = await authService.login(loginForm.email, loginForm.password);

                //show other page if the user data is correct
                final loading = PageRouteBuilder(pageBuilder: ((context, __, ___) => ChangeNotifierProvider(create: (context)=>LoginFormProvider(), child: LoadingScreen(userEmail: loginForm.email,))));
                
                errorMessage == null ? Navigator.pushReplacement(context, loading ): NotificationService.showSnackbar("Incorrect user or password");
                
              }

              //Register the user 
              if (text == "Register"){
                final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password);
                (errorMessage == null) ? Navigator.pushReplacementNamed(context, "login"): NotificationService.showSnackbar(errorMessage);
              }
            }
          ),
      
      
          CustomTextButton(route: route, text: route),
      
          ]
        ),
      ),
    );
  }
}


