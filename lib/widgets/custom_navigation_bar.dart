import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
//import 'package:qr_reader/theme/app_theme.dart';

import '../providers/ui_provider.dart';
import '../themes/appTheme.dart';



class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
 
    return BottomNavigationBar(
      onTap: (int i)=> uiProvider.selectedMenuOption = i,
      currentIndex: uiProvider.selectedMenuOption,
      items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted_rounded, color: AppTheme.primary), label: "Historial de Visitantes"),
      BottomNavigationBarItem(icon: Icon(Icons.person_rounded, color: AppTheme.primary), label: "Residentes"),
    ]);
  }
}
