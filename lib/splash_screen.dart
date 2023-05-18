import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypropertyuk/mtp_app_home.dart';
import 'package:mypropertyuk/screens/mtp_add_new_property.dart';
import 'package:mypropertyuk/screens/mtp_login_screen.dart';
import 'package:mypropertyuk/screens/mtp_property_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/mtp_constants.dart';

String? finalToken;
class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    isUserLoggedIn().whenComplete(() async{
      if(finalToken==null){
        Timer(Duration(seconds: 2), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen())));
      }
else{
        Timer(Duration(seconds: 2), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MtpAppHome())));
      }
    });
  }




  Future isUserLoggedIn() async {
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var usertoken=sharedPreferences.getString("user_token");
    setState(() {
      finalToken=usertoken;
      //print(finalToken);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.kToDark.shade100,
      body: Stack(
        children: [
          splashscreen(context),
        ],
      ),
    );
  }
}

Widget splashscreen(context){
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/app_icon.png",height: 240,),
          Text(
            "My Total Property",
            style: TextStyle(
                fontSize: 28,
                fontFamily: "Ubuntu",
                fontWeight: FontWeight.w700
            ),
          ),
        ],
      ),
    ),
  );
}




