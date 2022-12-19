import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_form_provider.dart';
import '../services/services.dart';


class CustomButton extends StatelessWidget {

  final Widget buttonChild;
  final String text;
  final void Function()? onPressed;

  const CustomButton({
    Key? key, 
    required this.buttonChild, 
    required this.text,
    this.onPressed, 
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.indigo,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30) ,bottomRight: Radius.circular(30))), 
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: buttonChild,
      ) 
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.route,
    required this.text,
  }) : super(key: key);

  final String route;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=> Navigator.pushReplacementNamed(context, route),        
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(text, style: const TextStyle(color: Colors.black54, fontSize: 15),),
      )
      );
  }
}