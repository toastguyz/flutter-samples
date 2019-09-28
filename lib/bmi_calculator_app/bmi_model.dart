import 'package:flutter/material.dart';

class BMIModel extends ChangeNotifier {
  String _bmiResult="";

  String get bmi => _bmiResult;

  void calculateBMI(int weight, int height) {
    double calculation=(weight) / ((height/100) * (height/100));
    _bmiResult="BMI : "+calculation.toStringAsFixed(2);

    print("BMI : "+_bmiResult);
    notifyListeners();
  }
}
