import 'package:flutter/material.dart';
import 'package:mypropertyuk/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}





