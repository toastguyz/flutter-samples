import 'package:flutter/material.dart';

TextStyle appBarStyle = TextStyle(color: Colors.black, fontSize: 24.0);
TextStyle messageStyle = TextStyle(color: Colors.black, fontSize: 28.0);
TextStyle titleStyle = TextStyle(color: Colors.black, fontSize: 28.0);
TextStyle subTitleStyle = TextStyle(color: Colors.black, fontSize: 28.0);
TextStyle hintSearchBarStyle = TextStyle(color: Colors.black54, fontSize: 20.0);

const Color gradientStartColor = Color(0xff636FA4);
const Color gradientEndColor = Color(0xffE8CBC0);

const Color gradientStartColor2 = Color(0xffee9ca7);
const Color gradientEndColor2 = Color(0xffffdde1);

const Color nearlyBlack = Color(0xFF213333);
const Color grey = Color(0xFF3A5160);
const Color dark_grey = Color(0xFF313A44);

const Color darkText = Color(0xFF253840);
const Color darkerText = Color(0xFF17262A);
const Color lightText = Color(0xFF4A6572);
const Color deactivatedText = Color(0xFF767676);
const Color dismissibleBackground = Color(0xFF364A54);

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}
