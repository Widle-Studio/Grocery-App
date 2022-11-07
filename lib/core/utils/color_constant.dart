import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color teal40023 = fromHex('#2336b37e');

  static Color bluegray8008f = fromHex('#8f37474f');

  static Color lightGreenA7002b = fromHex('#2b5ec401');

  static Color gray51 = fromHex('#fafafa');

  static Color bluegray50 = fromHex('#f0f1f2');

  static Color black9003d = fromHex('#3d000000');

  static Color lightGreenA700 = fromHex('#5ec401');

  static Color lightGreenA700A9 = fromHex('#a95ec401');

  static Color blue7001e = fromHex('#1e236cd9');

  static Color redA200B7 = fromHex('#b7ff5552');

  static Color gray50 = fromHex('#fafbff');

  static Color bluegray8002b = fromHex('#2b37474f');

  static Color black9001e = fromHex('#1e000000');

  static Color teal400 = fromHex('#36b37e');

  static Color lightBlue40033 = fromHex('#3319aaf8');

  static Color whiteA70099 = fromHex('#99ffffff');

  static Color black900 = fromHex('#000000');

  static Color black90063 = fromHex('#63000000');

  static Color yellow900 = fromHex('#f37a20');

  static Color bluegray80090 = fromHex('#9037474f');

  static Color whiteA7008c = fromHex('#8cfefefe');

  static Color redA20023 = fromHex('#23ff5552');

  static Color gray5099 = fromHex('#99fcfcfc');

  static Color gray600 = fromHex('#777777');

  static Color gray700 = fromHex('#545454');

  static Color gray400 = fromHex('#c5c5c5');

  static Color whiteA7006c = fromHex('#6cffffff');

  static Color gray301 = fromHex('#e8e8e3');

  static Color blue700 = fromHex('#236cd9');

  static Color blue70023 = fromHex('#23236cd9');

  static Color gray800 = fromHex('#3e3e3e');

  static Color redA200 = fromHex('#ff5552');

  static Color gray801 = fromHex('#4e4e4e');

  static Color bluegray800B7 = fromHex('#b737474f');

  static Color black9000c = fromHex('#0c000000');

  static Color gray200 = fromHex('#f0f0f0');

  static Color gray300 = fromHex('#e0e0e0');

  static Color blue700A9 = fromHex('#a9236cd9');

  static Color gray100 = fromHex('#f3f4f4');

  static Color bluegray8007f = fromHex('#7f37474f');

  static Color bluegray800 = fromHex('#37474f');

  static Color yellow90023 = fromHex('#23f37a20');

  static Color bluegray400 = fromHex('#888888');

  static Color bluegray800A9 = fromHex('#a937474f');

  static Color black90030 = fromHex('#30000000');

  static Color whiteA700 = fromHex('#ffffff');

  static Color bluegray80023 = fromHex('#2337474f');

  static Color bluegray80089 = fromHex('#8937474f');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
