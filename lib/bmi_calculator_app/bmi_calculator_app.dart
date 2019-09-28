import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/bmi_calculator_app/bmi_model.dart';
import 'package:provider/provider.dart';

class BMICalculatorApp extends StatefulWidget {
  @override
  _BMICalculatorAppState createState() => _BMICalculatorAppState();
}

class _BMICalculatorAppState extends State<BMICalculatorApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bmiModel = Provider.of<BMIModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _buildBMIPage(bmiModel),
    );
  }

  Widget _buildBMIPage(BMIModel bmiModel) {
    return Center(
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: constraints.maxWidth * 0.5,
                        child: TextFormField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Enter Height",
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          validator: (height) {
                            if (height.isEmpty) {
                              return "Enter Height !!";
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: constraints.maxWidth * 0.5,
                        child: TextFormField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Weight",
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          validator: (height) {
                            if (height.isEmpty) {
                              return "Enter Height !!";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Calculate BMI",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                          wordSpacing: 1.5),
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();

                    bmiModel.calculateBMI(int.parse(weightController.text),
                        int.parse(heightController.text));
                  },
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    bmiModel.bmi,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
