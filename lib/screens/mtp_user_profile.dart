import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mypropertyuk/screens/mtp_login_screen.dart';
import 'package:mypropertyuk/shared/ApiConstants.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/get_property_response_model.dart';

class MtpUserProfile extends StatefulWidget {
  const MtpUserProfile({Key? key}) : super(key: key);

  @override
  State<MtpUserProfile> createState() => _MtpUserProfileState();
}

String logedInusername="";
String logedInuseremail="";
String logedInuserid="";
List<GetPropertyResponseModel> properties=[];
List userProps=[];
int totalproperty=0;



class _MtpUserProfileState extends State<MtpUserProfile> {

  @override
  void initState() {
    getUserPrefrences().whenComplete(() => getAllPropertiesByuserId());
    super.initState();

  }

  Future getUserPrefrences() async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String username=sharedPreferences.getString("user_name").toString();
    String useremail=sharedPreferences.getString("user_email").toString();
    String userid=sharedPreferences.getString("user_id").toString();

    setState(() {
      logedInuseremail=useremail;
      logedInusername=username;
      logedInuserid=userid;
    });

  }

  Future<List<GetPropertyResponseModel>> getAllPropertiesByuserId() async{

    var url=Uri.parse(ApiConstants.BASE_URL+"get_property.php");
    var response=await http.post(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName("utf-8"),
        body:{"user_id":"$logedInuserid"}
    );

    var data = jsonDecode(response.body);
    userProps=data["data"];
    setState(() {
      totalproperty=userProps.length;
    });
    return userProps.map((data) => new GetPropertyResponseModel.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.kToDark.shade100,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 250,
                        color: Palette.kToDark.shade200,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Row(
                              children: [
                                const Text(
                                  "Settings",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white
                                  ),
                                ),
                                const Spacer(),
                                TextButton(onPressed: () async{
                                  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                                  sharedPreferences.remove("user_token");
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                }, child: const Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white
                                  ),
                                ),
                                )

                              ],
                            )
                        ),
                      ),
                      Positioned(
                        child: Center(child: Image.asset('assets/man.png',height: 120,)),
                        right: 0,
                        left: 0,
                        bottom: -56,
                      ),
                    ],
                  ),
                  SizedBox(height: 60,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment. center,
                    children: [
                      const SizedBox(width: 10,),
                      Text(
                        "Hello, $logedInusername",
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Ubuntu'
                        ),
                      ),
                      const SizedBox(height: 3,),
                      Text(
                        "$logedInuseremail",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Ubuntu'
                        ),
                      ),
                      const SizedBox(height: 40,),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Palette.kToDark.shade200,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Palette.kToDark.shade800,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Icon(Icons.maps_home_work_outlined,size: 35,color: Palette.kToDark.shade100,),
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Properties",
                                      style: TextStyle(
                                          fontFamily: "Ubuntu",
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200
                                      ),
                                    ),
                                    Text(
                                      "$totalproperty",
                                      style: TextStyle(
                                          fontFamily: "Ubuntu",
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 80,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Palette.kToDark.shade200,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Palette.kToDark.shade800,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Icon(Icons.attach_money_outlined,size: 35,color: Palette.kToDark.shade100,),
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expenses",
                                      style: TextStyle(
                                          fontFamily: "Ubuntu",
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200
                                      ),
                                    ),
                                    Text(
                                      "125.6K",
                                      style: TextStyle(
                                          fontFamily: "Ubuntu",
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -1
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ]
            ),
          )
        ],
      ),
    );
  }
}
