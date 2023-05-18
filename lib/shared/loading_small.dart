import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mypropertyuk/shared/mtp_constants.dart';

class LoadingSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.kToDark.shade100,
      child: SizedBox(
        height: 40,
        child: Center(
          child: SpinKitFadingCube(
            color: Colors.brown,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}