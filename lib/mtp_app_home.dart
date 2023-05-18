import 'package:flutter/material.dart';
import 'package:mypropertyuk/screens/mtp_forms_and_docs.dart';
import 'package:mypropertyuk/screens/mtp_property_screen.dart';
import 'package:mypropertyuk/screens/mtp_reports.dart';
import 'package:mypropertyuk/screens/mtp_tools_screen.dart';
import 'package:mypropertyuk/screens/mtp_user_profile.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';
class MtpAppHome extends StatefulWidget {
  const MtpAppHome({Key? key}) : super(key: key);

  @override
  State<MtpAppHome> createState() => _MtpAppHomeState();
}
int totalproperty=0;


class _MtpAppHomeState extends State<MtpAppHome> {
  bool loading=false;
  int _currentIndex = 0;
  final screens=[
    MtpUserProfile(),
    AllPropertiesScreen(),
    MtpReports(),
    MtpPreletting(),
    MtpTools()
  ];

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Palette.kToDark.shade800,
        selectedItemColor: Palette.kToDark.shade900,
        iconSize: 30,
        elevation: 0,
        unselectedItemColor: Colors.white54,
        onTap: (value){
          setState(() {
            _currentIndex=value;

          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_work_sharp),
              label: 'Properties'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_sharp),
              label: 'Reports'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet_sharp),
              label: 'Pre-Letting'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate_sharp),
              label: 'Tools'
          ),
        ],

      ),
      backgroundColor: Palette.kToDark.shade100,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      )
    );
  }
}
