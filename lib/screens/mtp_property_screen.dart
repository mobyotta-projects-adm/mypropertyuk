import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mypropertyuk/models/get_property_response_model.dart';
import 'package:mypropertyuk/screens/mtp_add_new_property.dart';
import 'package:mypropertyuk/screens/mtp_single_property_screen.dart';
import 'package:mypropertyuk/shared/loading_small.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/ApiConstants.dart';

String logedInusername="";
String logedInuseremail="";
String logedInuserid="";
String selectedPropertyId="";
String selectedPropertyName="";
String selectedPropertyAddress="";
String selectedPropertyDesc="";
String selectedPropertyImg1="";
String selectedPropertyImg2="";
String selectedPropertyImg3="";
String selectedPropertyImg4="";
String selectedPropertyImg5="";
List<GetPropertyResponseModel> properties=[];
class AllPropertiesScreen extends StatefulWidget {

  @override
  State<AllPropertiesScreen> createState() => _AllPropertiesScreenState();
}


class _AllPropertiesScreenState extends State<AllPropertiesScreen> {

  bool loading=false;
  int propertyPageIndex = 1;

  @override
  void initState() {
    super.initState();
    getUserPrefrences().whenComplete(() => getAllPropertiesByuserId());
    
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
    List userProps=data["data"];
    return userProps.map((data) => new GetPropertyResponseModel.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if(propertyPageIndex==1){
      return Scaffold(
        backgroundColor: Palette.kToDark.shade100,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Text(
                                "All Properties",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Ubuntu'
                                ),
                              ),

                            ],
                          )
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/man.png',height: 60,),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello, $logedInusername",
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Ubuntu'
                                      ),
                                    ),
                                    SizedBox(height: 3,),
                                    Text(
                                      "$logedInuseremail",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Ubuntu'
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 40,),
                            MaterialButton(onPressed: () async{
                              setState(() {
                                propertyPageIndex=2;
                              });
                            },
                              child: Text("Add New Property"), color: Palette.kToDark.shade800,)
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      propertyList(context),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    else if(propertyPageIndex==2){
      return AddPropertyScreen();
    }
    else{
      return MtpSinglePropertyScreen(
          propName: selectedPropertyName,
          propAddress: selectedPropertyAddress,
          propDesc: selectedPropertyDesc,
          propImg1: selectedPropertyImg1,
          propImg2: selectedPropertyImg2,
          propImg3: selectedPropertyImg3,
          propImg4: selectedPropertyImg4,
          propImg5: selectedPropertyImg5);
    }

  }

  Widget propertyList(context){
    return SingleChildScrollView(
      child: FutureBuilder<List<GetPropertyResponseModel>>(
        future: getAllPropertiesByuserId(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i){
                    return InkWell(
                      child: Card(
                        color: Palette.kToDark.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              FadeInImage(placeholder: AssetImage("assets/app_icon.png"), image: NetworkImage(snapshot.data![i].propImageOne), height: 110, width: 110, fit: BoxFit.cover,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![i].propName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Ubuntu',
                                        fontSize: 22
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![i].propAddress,
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 14,
                                        fontStyle: FontStyle.italic
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Flexible(
                                      child: Text(
                                        snapshot.data![i].propDescription,
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          selectedPropertyId=snapshot.data![i].propId;
                          selectedPropertyName=snapshot.data![i].propName;
                          selectedPropertyAddress=snapshot.data![i].propAddress;
                          selectedPropertyDesc=snapshot.data![i].propDescription;
                          selectedPropertyImg1=snapshot.data![i].propImageOne;
                          selectedPropertyImg2=snapshot.data![i].propImageTwo;
                          selectedPropertyImg3=snapshot.data![i].propImageThree;
                          selectedPropertyImg4=snapshot.data![i].propImageFour;
                          selectedPropertyImg5=snapshot.data![i].propImageFive;
                          propertyPageIndex=3;

                        });
                      },
                    );
                  },
                );
          }
          else if(snapshot.hasError){
            return Container(
              child: Text("No properties to show!"),
            );
          }
          return LoadingSmall();
        }
      ),
    );
  }
}







