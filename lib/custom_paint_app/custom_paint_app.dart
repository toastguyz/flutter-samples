import 'package:flutter/material.dart';

class CustomPaintApp extends StatefulWidget {
  @override
  _CustomPaintAppState createState() => _CustomPaintAppState();
}

class _CustomPaintAppState extends State<CustomPaintApp> {
  var boxSize = 150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Button"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    hintText: "Enter Size",
                  ),
                  onSubmitted: (String size) {
                    if (size.isNotEmpty) {
                      setState(() {
                        boxSize = double.parse(size);
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                height: boxSize,
                width: boxSize,
                child: CustomPaint(
                  foregroundPainter: MyPainter(
                      lineColor: Colors.blue,
                      completeColor: Colors.green,
                      width: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: RaisedButton(
                        color: Colors.black38,
                        shape: RoundedRectangleBorder(),
                        child: Text("Size : ${boxSize}",style: TextStyle(color: Colors.white),),
                        onPressed: () {}),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double width;

  MyPainter({this.lineColor, this.completeColor, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Path path = Path();
    path.moveTo(0, size.height / 10);
    path.quadraticBezierTo(0, 0, size.width / 10, 0);
    path.lineTo(size.width - size.width / 10, 0);

    canvas.drawPath(path, line);

    Path secondPath = Path();
    secondPath.moveTo(size.width - size.width / 10, 0);
    secondPath.quadraticBezierTo(size.width, 0, size.width, size.height / 10);
    secondPath.lineTo(size.width, size.height - size.height / 10);
    secondPath.quadraticBezierTo(
        size.width, size.height, size.width - size.width / 10, size.height);
    secondPath.lineTo(size.width / 10, size.height);

    canvas.drawPath(secondPath, complete);

    Path thirdPath = Path();
    thirdPath.moveTo(size.width / 10, size.height);
    thirdPath.quadraticBezierTo(
        0, size.height, 0, size.height - size.height / 10);
    thirdPath.lineTo(0, size.height / 10);

    canvas.drawPath(thirdPath, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
