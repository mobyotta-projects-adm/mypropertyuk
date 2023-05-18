import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mypropertyuk/mtp_app_home.dart';
import 'package:mypropertyuk/screens/mtp_property_screen.dart';
import 'package:mypropertyuk/screens/mtp_user_profile.dart';
import 'package:mypropertyuk/shared/loading.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';
import 'package:mypropertyuk/screens/mtp_register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/ApiConstants.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Future loginuser(BuildContext context, String userEmail, String userPassword) async{
  var url=Uri.parse(ApiConstants.BASE_URL+"api.php?apicall=login");
  var response=await http.post(url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName("utf-8"),
      body:{"user_email":userEmail, "user_password":userPassword}
  );
  var data=json.decode(response.body);

  if(data["code"]==200){
    String responseString=response.body;
  }
  return data["data"];
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _loginformkey = GlobalKey<FormState>();

  TextEditingController loginemailcontroller=TextEditingController();
  TextEditingController loginpasswordcontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Palette.kToDark.shade100,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Form(
                  key: _loginformkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Image.asset('assets/loginscreenicon.png',height: 140,),
                      SizedBox(height: 20),
                      Text(
                        "Login to your Account",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Ubuntu'
                        ),
                      ),
                      SizedBox(height: 40),

                      TextFormField(
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        controller: loginemailcontroller,
                        validator: (formvalue){
                          if(formvalue==null || formvalue.isEmpty){
                            return "Email cannot be blank";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          border: InputBorder.none,
                          fillColor: Palette.kToDark.shade600,
                          filled: true,
                          hintText: "Email",
                          contentPadding: EdgeInsets.all(18.0),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        obscureText: true,
                        controller: loginpasswordcontroller,
                        validator: (formvalue){
                          if(formvalue==null || formvalue.isEmpty){
                            return "Password cannot be blank";
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          border: InputBorder.none,
                          fillColor: Palette.kToDark.shade600,
                          filled: true,
                          hintText: "Password",
                          contentPadding: EdgeInsets.all(18.0),

                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Palette.kToDark.shade800,
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () async {
                            if(_loginformkey.currentState!.validate()){
                              setState(()=>loading=true);
                              String loginEmail=loginemailcontroller.text;
                              String loginpass=loginpasswordcontroller.text;

                              var response=await loginuser(context, loginEmail, loginpass);
                              setState(() async {
                                loading=false;
                                final SharedPreferences userPref = await SharedPreferences.getInstance();
                                userPref.setString("user_id", response["user_id"]);
                                userPref.setString("user_email", response["user_email"]);
                                userPref.setString("user_name", response["user_name"]);
                                userPref.setString("user_token", response["user_token"]);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>MtpAppHome()));
                              });
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          )
                      ),
                      const SizedBox(height: 80,),
                      TextButton(onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen())),
                          child: Text("Don't have an account? Register Now",
                            style: TextStyle(
                                color: Palette.kToDark.shade900,
                                fontSize: 16
                            ),))

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



