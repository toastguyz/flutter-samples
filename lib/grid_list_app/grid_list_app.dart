import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridListApp extends StatefulWidget {
  @override
  _GridListAppState createState() => _GridListAppState();
}

class _GridListAppState extends State<GridListApp> {
  var routeName = [
    "Grid List App",
    "Sliver Grid List App",
    "Sliver List App",
    "Sticky Header Sliver List App",
    "Gestures & Inkwell App",
    "BMI Calculator App",
    "Image Picker App",
    "Note Keeper App",
    "Bloc Counter App",
    "Bloc Fifa Players Search App",
    "Provider Counter App",
    "Provider Shopper App",
    "Provider Web API App",
    "FutureBuilderApp",
    "Provider - FutureBuilder App",
    "DateTimePicker App",
    "Story UI App",
    "Image Clipper App",
    "PageView Box Animation App",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridList app"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
            ),
            itemCount: routeName.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(5.0),
                child: RaisedButton(
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: Text(
                    routeName[index],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    final snackBar = SnackBar(
                      content: Text("Item Tapped !!"),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
