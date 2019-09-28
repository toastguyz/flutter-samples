import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverListApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SliverListAppState();
  }
}

class SliverListAppState extends State<SliverListApp> {
  var isInit = true;
  var args;

  Widget _buildSliverGridList(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(
            "Sliver Grid List",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          floating: true,
          pinned: true,
          flexibleSpace: Image.network(
            "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
            fit: BoxFit.cover,
          ),
          expandedHeight: 200,
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              title: Text("Item ${index}"),
            );
          }, childCount: 100),
        ),
      ],
    );
  }

  Widget _buildSliverList(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Sliver Normal List",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            background: Image.network(
              "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
              fit: BoxFit.cover,
            ),
          ),
          expandedHeight: 200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              title: Text("Item ${index}"),
            );
          }, childCount: 100),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
//    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var args = ModalRoute.of(context).settings.arguments;
    print("args ${args}");

    return Scaffold(
        body: args != null && args
            ? _buildSliverList(context)
            : _buildSliverGridList(context));
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      args= ModalRoute.of(context).settings.arguments;
      isInit = false;
    }
    super.didChangeDependencies();
  }
}
