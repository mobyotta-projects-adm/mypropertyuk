import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffbeab9f, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffeaede6),//10%
      100: Color(0xffccbbae),//20%
      200: Color(0xffbeab9f),//30%
      300: Color(0xffd4c4bc),//40%
      400: Color(0xffeacbb4),//50%
      500: Color(0xffb49c8f),//60%
      600: Color(0xffb5a494),//70%
      700: Color(0xffac968c),//80%
      800: Color(0xff9c8373),//90%
      900: Color(0xff000000),//100%
    },
  );
}


