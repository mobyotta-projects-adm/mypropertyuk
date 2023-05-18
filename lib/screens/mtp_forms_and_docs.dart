import 'package:flutter/material.dart';
import 'package:mypropertyuk/screens/pdf_view_screen.dart';
import 'package:mypropertyuk/shared/PDFApi.dart';
import 'package:mypropertyuk/shared/loading.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class MtpPreletting extends StatefulWidget {
  const MtpPreletting({Key? key}) : super(key: key);

  @override
  State<MtpPreletting> createState() => _MtpPrelettingState();
}

List<String> formUrls=[
  'http://mobyottadevelopers.online//mtp/property/api/docs/check_list.pdf',
  'http://mobyottadevelopers.online//mtp/property/api/docs/tenant_application_form.pdf',
  'http://mobyottadevelopers.online//mtp/property/api/docs/landlord_ref_req.pdf',
  'http://mobyottadevelopers.online//mtp/property/api/docs/character_ref_req.pdf',
];
int selectedPdfIndex=0;
String selectedPdfUrl="";
bool isLoadingPdf=PDFApi().isLoadingPdf;


class _MtpPrelettingState extends State<MtpPreletting> {

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPdf==false ? Scaffold(
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
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Forms and documentation",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Ubuntu'
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40,),
                          TextButton(
                              onPressed: () async {
                                selectedPdfIndex = 1;
                                selectedPdfUrl = formUrls[selectedPdfIndex - 1];
                                setState(() {
                                  isLoadingPdf=true;
                                });
                                Future.delayed(const Duration(seconds: 3), () {
                                  setState(() {
                                    isLoadingPdf=false;
                                  });

                                });
                                final file = await PDFApi.loadFromNetwork(selectedPdfUrl);
                                openPDF(context, file, "My Letting Checklist");

                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                  )
                              ),
                              child: Text(
                                  "My Letting Checklist",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  )
                              )
                          ),
                          Divider(
                            height: 35,
                            thickness: 1,
                            indent: 10,
                            endIndent: 0,
                            color: Palette.kToDark.shade800,
                          ),
                          TextButton(
                              onPressed: () async {
                                selectedPdfIndex = 2;
                                selectedPdfUrl = formUrls[selectedPdfIndex - 1];

                                setState(() {
                                  isLoadingPdf=true;
                                });
                                Future.delayed(const Duration(seconds: 3), () {
                                  setState(() {
                                    isLoadingPdf=false;
                                  });

                                });

                                final file = await PDFApi.loadFromNetwork(selectedPdfUrl);
                                openPDF(context, file, "Tenant Application Form");

                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                  )
                              ),
                              child: Text(
                                  "Tenant Application Form",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  )
                              )
                          ),
                          Divider(
                            height: 35,
                            thickness: 1,
                            indent: 10,
                            endIndent: 0,
                            color: Palette.kToDark.shade800,
                          ),
                          TextButton(
                              onPressed: () async {
                                selectedPdfIndex = 3;
                                selectedPdfUrl = formUrls[selectedPdfIndex - 1];

                                setState(() {
                                  isLoadingPdf=true;
                                });
                                Future.delayed(const Duration(seconds: 3), () {
                                  setState(() {
                                    isLoadingPdf=false;
                                  });

                                });

                                final file = await PDFApi.loadFromNetwork(selectedPdfUrl);
                                openPDF(context, file, "Landlord Reference Form");

                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                  )
                              ),
                              child: Text(
                                  "Landlord Reference Form",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  )
                              )
                          ),
                          Divider(
                            height: 35,
                            thickness: 1,
                            indent: 10,
                            endIndent: 0,
                            color: Palette.kToDark.shade800,
                          ),
                          TextButton(
                              onPressed: () async {
                                selectedPdfIndex = 4;
                                selectedPdfUrl = formUrls[selectedPdfIndex - 1];

                                setState(() {
                                  isLoadingPdf=true;
                                });
                                Future.delayed(const Duration(seconds: 3), () {
                                  setState(() {
                                    isLoadingPdf=false;
                                  });

                                });

                                final file = await PDFApi.loadFromNetwork(selectedPdfUrl);
                                openPDF(context, file, "Character Reference Form");
                              },
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                  )
                              ),
                              child: Text(
                                  "Character Reference Form",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  )
                              )
                          ),
                          Divider(
                            height: 35,
                            thickness: 1,
                            indent: 10,
                            endIndent: 0,
                            color: Palette.kToDark.shade800,
                          ),


                        ],
                      ),
                    )


                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ) : Loading();
  }

  Future<void> requestStoragePermission() async {
    final serviceStatusStorage = await Permission.storage.isGranted;

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

  void openPDF(BuildContext context, File file, String filename) =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PDFViewPage(filename: filename, file: file,)));


}
