import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureInkwellApp extends StatefulWidget {
  @override
  _GestureInkwellAppState createState() => _GestureInkwellAppState();
}

class _GestureInkwellAppState extends State<GestureInkwellApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gesture - Inkwell"),
      ),
      body: _buildGestureInkPage(),
    );
  }

  Widget _buildGestureInkPage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: RaisedButton(
              color: Colors.green,
              onPressed: () {},
              child: Text("Gesture Detector"),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text("InkWell"),
              ),
              splashColor: Colors.yellow,
              hoverColor: Colors.red,
              focusColor: Colors.deepPurple,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Ink(
            color: Colors.orange,
            child: InkWell(
              splashColor: Colors.red,
              child: Container(
                height: 50.0,
                width: 50.0,
                child: Center(
                  child: Text("My Chip",
                      style: Theme.of(context).textTheme.body1),
                ),
              ),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Material(
            child: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  color: Colors.green,
                  child: Center(
                    child: Text("My Chip",
                        style: Theme.of(context).textTheme.body1),
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
