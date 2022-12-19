import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:residentes/screens/resident_screen.dart';



import '../providers/providers.dart';
import '../services/services.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class GuardScreen extends StatelessWidget {
   
  const GuardScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final userService = Provider.of<UserService>(context);
    final authService = Provider.of<AuthService>(context);

    if ( userService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(leading: IconButton(
        onPressed: (){
          authService.logout();
          Navigator.pushReplacementNamed(context, "checking");
          }, 
        icon: const Icon(Icons.login_outlined)) 
      ),
      body: _HomePagesBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class _HomePagesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointmentService = Provider.of<AppointmentService>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOption;

    //final tempScan = new ScanModel(valor: 'http://google.com');
    //DBProvider.db.nuevoScan(tempScan);

    switch(currentIndex){
      case 0:
        return HistoryScreen();
      
      case 1:
        return ResidentScreen();
    }

    return LoginScreen();
  }
}