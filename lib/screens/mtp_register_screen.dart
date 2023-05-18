import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypropertyuk/shared/ApiConstants.dart';
import 'package:mypropertyuk/shared/loading.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';
import 'package:mypropertyuk/screens/mtp_login_screen.dart';
import 'package:http/http.dart' as http;
import '../models/useregistermodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

Future<UserModel> registerUser (BuildContext context,String name, String email, String phone, String password) async{
  UserModel userModel=new UserModel(userName: name, userEmail: email, userPhone: phone, userPassword: password);
  var url=Uri.parse(ApiConstants.BASE_URL+"api.php?apicall=signup");
  var response=await http.post(url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName("utf-8"),
      body:{"user_name":name, "user_email":email, "user_phone":phone, "user_password":password}
  );
  var data=json.decode(response.body);
  // print(url);
  // print(data);

  if(data['code']==201){
    showAlertDialog(context);
  }

  return userModel;
}



class _RegisterScreenState extends State<RegisterScreen> {
  late UserModel _usermodal;
  bool loading = false;
  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Palette.kToDark.shade100,
      body: Stack(
        children: [
SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Image.asset('assets/building.png',height: 140,),
                SizedBox(height: 20),
                Text(
                  "Create an account to get started",
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
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Name cannot be blank";
                    }
                    return null;
                  },
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: InputBorder.none,
                    fillColor: Palette.kToDark.shade600,
                    filled: true,
                    hintText: "Name",
                    contentPadding: EdgeInsets.all(18.0),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  controller: emailController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Email cannot be empty";
                    }
                    return null;
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
                  controller: phoneController,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Phone cannot be blank";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: InputBorder.none,
                    fillColor: Palette.kToDark.shade600,
                    filled: true,
                    hintText: "Phone",
                    contentPadding: EdgeInsets.all(18.0),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  controller: passwordController,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                  obscureText: true,
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
                    onPressed: () async{
                      if(_formkey.currentState!.validate()){
                        setState(() => loading = true);
                        String name=nameController.text;
                        String email=emailController.text;
                        String phone=phoneController.text;
                        String password=passwordController.text;

                        UserModel userdata=await registerUser(context,name, email, phone, password);
                        setState(() {
                          _usermodal=userdata;
                          loading=false;
                        });
                      }
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 18),
                    )
                ),
                SizedBox(height: 10,),
                TextButton(onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen())),
                    child: Text("Already have an account? Login Now",
                      style: TextStyle(
                          color: Palette.kToDark.shade900,
                          fontSize: 16
                      ),)),



              ],
            ),
          ),
        ),
      ),
    )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("Registration successfull. You can login now"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


  




  
