import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/appTheme.dart';

class CustomTextField extends StatelessWidget {

  final bool autocorrect;
  final bool obscureText;
  final IconData? prefixIcon;
  final InputBorder BorderSide;
  final InputBorder? focusedBorder;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? helperText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatter;
   
  
  const CustomTextField({
    Key? key, 
    this.autocorrect = false,
    this.controller,
    this.focusedBorder, 
    this.helperText,
    this.hintText, 
    this.inputFormatter, 
    this.keyboardType,
    this.obscureText = false,
    this.onChange, 
    this.onTap, 
    this.prefixIcon, 
    this.validator, 
    required this.BorderSide, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: autocorrect,
      obscureText: obscureText,
      decoration: InputDecoration(
        helperText: helperText,
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Icon(prefixIcon, color: AppTheme.primary,)),
        border: BorderSide, focusedBorder: focusedBorder ),
      keyboardType: keyboardType,  
      onChanged: onChange,
      validator: validator,
      onTap: onTap,
      controller: controller,
      inputFormatters: inputFormatter,
      
        
        );
  }
}

// color: Colors.red, width: 5),
//               borderRadius:
//                   BorderRadius.only(topRight: Radius.circular(20)