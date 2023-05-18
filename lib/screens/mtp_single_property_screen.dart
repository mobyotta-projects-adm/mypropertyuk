import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mypropertyuk/screens/mtp_property_screen.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';

class MtpSinglePropertyScreen extends StatefulWidget {
  final String propName;
  final String propAddress;
  final String propDesc;
  final String propImg1;
  final String propImg2;
  final String propImg3;
  final String propImg4;
  final String propImg5;
  const MtpSinglePropertyScreen({Key? key, required this.propName, required this.propAddress, required this.propDesc, required this.propImg1, required this.propImg2, required this.propImg3, required this.propImg4, required this.propImg5}) : super(key: key);

  @override
  State<MtpSinglePropertyScreen> createState() => _MtpSinglePropertyScreenState();
}

class _MtpSinglePropertyScreenState extends State<MtpSinglePropertyScreen> {
  int sPropPageIndex=1;

  @override
  Widget build(BuildContext context) {

    final List<String> imgList=[
      widget.propImg1,
      widget.propImg2,
      widget.propImg3,
      widget.propImg4,
      widget.propImg5,
    ];
    if(sPropPageIndex==1){
      return WillPopScope(
        child: Scaffold(
          backgroundColor: Palette.kToDark.shade200,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){
                              setState(() {
                                sPropPageIndex=2;
                              });
                            }, icon: Icon(Icons.chevron_left,size: 40,)),
                            SizedBox(width: 10,),
                            Text(
                              widget.propName,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Ubuntu'
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    autoPlayAnimationDuration: Duration(milliseconds: 300),
                                    autoPlayCurve: Curves.linearToEaseOut
                                ),
                                items: imgList
                                    .map((item) => Container(
                                  child: Center(
                                      child:
                                      Image.network(item, fit: BoxFit.cover, width: 1000)),
                                ))
                                    .toList(),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "Address:",
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              Text(
                                widget.propAddress,
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "Description:",
                                style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              Text(
                                widget.propDesc,
                                style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        onWillPop: () async{
          return false;
        },
      );
    }
    else{
      return AllPropertiesScreen();
    }
  }
}
