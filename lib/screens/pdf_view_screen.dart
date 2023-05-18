import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:mypropertyuk/shared/PDFApi.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';

class PDFViewPage extends StatefulWidget {

  final File file;
  final String filename;
  const PDFViewPage({Key? key,required this.file, required this.filename}) : super(key: key);

  @override
  State<PDFViewPage> createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filename),
        backgroundColor: Palette.kToDark.shade200,
      ),
      body: PDFView(
        filePath: widget.file.path,
        fitEachPage: true,
      ),
    );
  }
}
