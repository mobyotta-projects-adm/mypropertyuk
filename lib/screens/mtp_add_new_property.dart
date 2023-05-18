import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io' as Io;
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:mypropertyuk/screens/mtp_property_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';
import 'package:permission_handler/permission_handler.dart';

import '../shared/ApiConstants.dart';
import '../shared/loading.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({Key? key}) : super(key: key);


  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  String logedInuserid="";
  Io.File? image;
  Io.File? propPickImage1;
  Io.File? propPickImage2;
  Io.File? propPickImage3;
  Io.File? propPickImage4;


  @override
  void initState() {
    super.initState();
    getUserPrefrences();
  }


  Future getUserPrefrences() async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String userid=sharedPreferences.getString("user_id").toString();

    setState(() {
      logedInuserid=userid;
    });

  }

  Future pickCoverImage() async {

    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null) return;

      final imageTemp=Io.File(image.path);
      setState(() {
        this.image=imageTemp;
      });
    } on PlatformException catch(e){
      Toast.show("Failed to pick image: $e");
    }
  }


  Future pickPropImages(String flag) async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null) return;

      final imageTemp=Io.File(image.path);
      setState(() {
        if(flag=="propPickImage1"){
          propPickImage1=imageTemp;
        }else if(flag=="propPickImage2"){
          propPickImage2=imageTemp;
        }else if(flag=="propPickImage3"){
          propPickImage3=imageTemp;
        }else{
          propPickImage4=imageTemp;
        }

      });
    } on PlatformException catch(e){
      Toast.show("Failed to pick image: $e");
    }
  }

  TextEditingController propNameControl= TextEditingController();
  TextEditingController propOwnerNameControl= TextEditingController();
  TextEditingController propAddressControl= TextEditingController();
  TextEditingController propDescriptionControl= TextEditingController();
  String ownerType = 'Landlord';

  bool loading=false;

  final _addPropertyKey = GlobalKey<FormState>();
  String propImage1="";
  String propImage2="";
  String propImage3="";
  String propImage4="";
  String propImage5="";

  int _propPageIndex=1;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    if(_propPageIndex==1){
      return loading==true ? Loading() : WillPopScope(
        onWillPop: () async{ return false; },
        child: Scaffold(
          backgroundColor: Palette.kToDark.shade100,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.fromLTRB(2, 16, 16, 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(onPressed: (){
                                setState(() {
                                  _propPageIndex=2;
                                });
                              }, icon: Icon(Icons.chevron_left,size: 40,)),
                              // SizedBox(width: 10,),
                              Spacer(),
                              Text(
                                "Add New Property",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Ubuntu'
                                ),
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: _addPropertyKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30,),
                                Row(
                                  children: [
                                    Container(
                                      child: image!=null ? Image.file(image!, height: 140, width: 140, fit: BoxFit.cover) : Image.asset("assets/villa.png",height: 140,width: 140, ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                          )
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Palette.kToDark.shade500,
                                          ),
                                          child: const Text(
                                            "Add cover image",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Ubuntu'
                                            ),
                                          ),
                                          onPressed: () async{
                                            requestStoragePermission();
                                            pickCoverImage().whenComplete((){
                                              propImage1=imageTobase64Convert();

                                            });

                                          },
                                        ),
                                        const SizedBox(height: 20,),
                                        const Text("Select Owner Type",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Ubuntu'
                                          ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 56, 5),
                                          color: Palette.kToDark.shade600,
                                          child: DropdownButton<String>(
                                            value: ownerType,
                                            icon: const Icon(Icons.expand_more),
                                            elevation: 16,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                ownerType = newValue!;
                                              });
                                            },
                                            items: <String>['Landlord', 'Rental']
                                                .map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                const Text("Property Name",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Ubuntu'
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                TextFormField(
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  controller: propNameControl,
                                  keyboardType: TextInputType.text,
                                  validator: (value){
                                    if(value==null || value.isEmpty){
                                      return "Property name cannot be blank";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(),
                                    border: InputBorder.none,
                                    fillColor: Palette.kToDark.shade600,
                                    filled: true,
                                    hintText: "Ex. Ceaser's Palace",
                                    hintStyle: const TextStyle(
                                        fontStyle: FontStyle.italic
                                    ),
                                    contentPadding: const EdgeInsets.all(18.0),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                const Text("Owner Name",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Ubuntu'
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                TextFormField(
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  controller: propOwnerNameControl,
                                  keyboardType: TextInputType.text,
                                  validator: (value){
                                    if(value==null || value.isEmpty){
                                      return "Owner cannot be blank";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(),
                                    border: InputBorder.none,
                                    fillColor: Palette.kToDark.shade600,
                                    filled: true,
                                    hintText: "Owner's Name",
                                    hintStyle: const TextStyle(
                                        fontStyle: FontStyle.italic
                                    ),
                                    contentPadding: const EdgeInsets.all(18.0),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                const Text("Where is this property located",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Ubuntu'
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                TextFormField(
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  controller: propAddressControl,
                                  keyboardType: TextInputType.multiline,
                                  validator: (value){
                                    if(value==null || value.isEmpty){
                                      return "Address cannot be blank";
                                    }
                                    return null;
                                  },
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(),
                                    border: InputBorder.none,
                                    fillColor: Palette.kToDark.shade600,
                                    filled: true,
                                    hintText: "Property Address",
                                    hintStyle: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                    contentPadding: const EdgeInsets.all(18.0),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                const Text("About the property",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Ubuntu'
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                TextFormField(
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  controller: propDescriptionControl,
                                  keyboardType: TextInputType.multiline,
                                  validator: (value){
                                    if(value==null || value.isEmpty){
                                      return "Description cannot be blank";
                                    }
                                    return null;
                                  },
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(),
                                    border: InputBorder.none,
                                    fillColor: Palette.kToDark.shade600,
                                    filled: true,
                                    hintText: "Ex. 4 bed, 2 bath, open kitchen ...",
                                    hintStyle: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                    contentPadding: const EdgeInsets.all(18.0),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                const Text("Add property photos",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Ubuntu'
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          child: propPickImage1!=null ? Image.file(propPickImage1!, height: 120, width: 120, fit: BoxFit.cover,) : Image.asset("assets/homesample.png", height: 120, width: 120,),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1
                                              )
                                          ),
                                          padding: const EdgeInsets.all(5.0),
                                        ),
                                        const SizedBox(height: 10,),
                                        ElevatedButton(
                                            onPressed: () async{
                                              requestStoragePermission();
                                              pickPropImages("propPickImage1").whenComplete((){
                                                propImage2=imageTobase64ConvertProp(propPickImage1!.path);


                                              });

                                            },
                                            child: const Text(
                                              "Add Photo 1",
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 16
                                              ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    Column(
                                      children: [
                                        Container(
                                          child: propPickImage2!=null ? Image.file(propPickImage2!, height: 120, width: 120, fit: BoxFit.cover,) : Image.asset("assets/homesample.png", height: 120, width: 120,),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1
                                              )
                                          ),
                                          padding: const EdgeInsets.all(5.0),
                                        ),
                                        const SizedBox(height: 10,),
                                        ElevatedButton(
                                            onPressed: () async{
                                              requestStoragePermission();
                                              pickPropImages("propPickImage2").whenComplete((){
                                                propImage3=imageTobase64ConvertProp(propPickImage2!.path);


                                              });

                                            },
                                            child: const Text(
                                              "Add Photo 2",
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 16
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          child: propPickImage3!=null ? Image.file(propPickImage3!, height: 120, width: 120, fit: BoxFit.cover,) : Image.asset("assets/homesample.png", height: 120, width: 120,),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1
                                              )
                                          ),
                                          padding: const EdgeInsets.all(5.0),
                                        ),
                                        const SizedBox(height: 10,),
                                        ElevatedButton(
                                            onPressed: () async{
                                              requestStoragePermission();
                                              pickPropImages("propPickImage3").whenComplete((){
                                                propImage4=imageTobase64ConvertProp(propPickImage3!.path);


                                              });

                                            },
                                            child: const Text(
                                              "Add Photo 3",
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 16
                                              ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    Column(
                                      children: [
                                        Container(
                                          child: propPickImage4!=null ? Image.file(propPickImage4!, height: 120, width: 120, fit: BoxFit.cover,) : Image.asset("assets/homesample.png", height: 120, width: 120,),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1
                                              )
                                          ),
                                          padding: const EdgeInsets.all(5.0),
                                        ),
                                        const SizedBox(height: 10,),
                                        ElevatedButton(
                                            onPressed: () async{
                                              requestStoragePermission();
                                              pickPropImages("propPickImage4").whenComplete((){
                                                propImage5=imageTobase64ConvertProp(propPickImage4!.path);

                                              });

                                            },
                                            child: const Text(
                                              "Add Photo 4",
                                              style: TextStyle(
                                                  fontFamily: 'Ubuntu',
                                                  fontSize: 16
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Palette.kToDark.shade900,
                                    minimumSize: const Size.fromHeight(50), // NEW
                                  ),
                                  onPressed: () async{
                                    if(_addPropertyKey.currentState!.validate()){
                                      if(propImage1.isEmpty){
                                        Toast.show("Please add cover image", gravity: Toast.center, duration: Toast.lengthLong);
                                      } else if(propImage2.isEmpty){
                                        Toast.show("Please property Photo 1", gravity: Toast.center, duration: Toast.lengthLong);
                                      } else if(propImage3.isEmpty){
                                        Toast.show("Please property Photo 2", gravity: Toast.center, duration: Toast.lengthLong);
                                      } else if(propImage4.isEmpty){
                                        Toast.show("Please property Photo 3", gravity: Toast.center, duration: Toast.lengthLong);
                                      } else if(propImage5.isEmpty){
                                        Toast.show("Please property Photo 4", gravity: Toast.center, duration: Toast.lengthLong);
                                      }

                                      else{
                                        //Toast.show("All Ok: $logedInuserid", gravity: Toast.center, duration: Toast.lengthLong);
                                        setState(()=> loading=true);
                                        String userid=logedInuserid;
                                        String prop_name=propNameControl.text;
                                        String prop_owner_name=propOwnerNameControl.text;
                                        String prop_owner_type=ownerType;
                                        String prop_address=propAddressControl.text;
                                        String prop_description=propDescriptionControl.text;


                                        var response= await addNewProperty(context,
                                            userid, prop_name, prop_owner_name,
                                            prop_owner_type, prop_address, prop_description,
                                            propImage1, propImage2, propImage3,
                                            propImage4, propImage5);
                                        if(response!=null && response["code"]==201){
                                          setState(() {
                                            loading=false;
                                            propNameControl.clear();
                                            propOwnerNameControl.clear();
                                            propAddressControl.clear();
                                            propDescriptionControl.clear();
                                            image=null;
                                            propImage1="";
                                            propImage2="";
                                            propImage3="";
                                            propImage4="";
                                            propImage5="";

                                            print(response);

                                            Toast.show("New Property Created!", gravity: Toast.center, duration: Toast.lengthLong);
                                            Timer(const Duration(seconds: 1),
                                                    (){
                                              _propPageIndex=2;

                                                });
                                          });
                                        }
                                        else{
                                          setState(() {
                                            loading=false;
                                            print(response);
                                            Toast.show("Something went wrong, Please try again", gravity: Toast.center, duration: Toast.lengthLong);
                                          });
                                        }
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Add Property',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )


                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    }
    else{
      return AllPropertiesScreen();
    }
  }
  Future<void> requestStoragePermission() async {

    final serviceStatusStorage = await Permission.storage.isGranted ;

    bool isLocation = serviceStatusStorage == ServiceStatus.enabled;

    final status = await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  String imageTobase64Convert(){
    final bytes = Io.File(image!.path);
    String img64 = base64Encode(bytes.readAsBytesSync());
    final mimetype=lookupMimeType(image!.path);
    return "data:"+mimetype.toString()+";base64,"+img64;
  }

  String imageTobase64ConvertProp(String path){
    final bytes = Io.File(path);
    String img64 = base64Encode(bytes.readAsBytesSync());
    final mimetype=lookupMimeType(path);
    return "data:"+mimetype.toString()+";base64,"+img64;
  }

  Future addNewProperty(
      BuildContext context,
      String user_id,
      String prop_name,
      String prop_owner_name,
      String prop_owner_type,
      String prop_address,
      String prop_description,
      String prop_image_one,
      String prop_image_two,
      String prop_image_three,
      String prop_image_four,
      String prop_image_five,
      ) async{
    var url=Uri.parse(ApiConstants.BASE_URL+"add_property.php");
    var response=await http.post(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName("utf-8"),
        body:{
          "user_id":user_id,
          "prop_name":prop_name,
          "prop_owner_name":prop_owner_name,
          "prop_owner_type":prop_owner_type,
          "prop_address":prop_address,
          "prop_description":prop_description,
          "prop_image_one": prop_image_one,
          "prop_image_two": prop_image_two,
          "prop_image_three": prop_image_three,
          "prop_image_four": prop_image_four,
          "prop_image_five": prop_image_five,
        }
    );
    var data=json.decode(response.body);

    if(data["code"]==201){
      String responseString=response.body;
    }
    return data;
  }
  


}



