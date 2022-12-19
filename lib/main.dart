import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:residentes/services/services.dart';
import 'package:residentes/themes/appTheme.dart';
import 'providers/providers.dart';
import 'screens/screens.dart';

void main() => runApp(AppState());


class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AppointmentService()),
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => UserService()),
        ChangeNotifierProvider(create: ( _ ) => UiProvider()),

        //ChangeNotifierProvider(create: ( _ ) => LoginFormProvider()),
        
    ],
    child: const MyApp(),
   );
  }
}



class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Alamos App',
      debugShowCheckedModeBanner: false,
      initialRoute: "checking",
      scaffoldMessengerKey: NotificationService.messengerKey,
      routes: {
        "checking":(_)=>const CheckAuthScreen(),
        "loading": ( _ )=>const LoadingScreen(),

        "login": ( _ )=>const LoginScreen(),
        "register": ( _ )=>const RegisterScreen(),


        "user": ( _ )=> UserScreen(),
        "guard": ( _ )=>const GuardScreen(),
        



      },
      theme: AppTheme.lightTheme,
    );
  }
}