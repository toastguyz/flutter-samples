import 'package:flutter/material.dart';

class StickyHeaderSliverListApp extends StatefulWidget {
  @override
  _StickyHeaderSliverListAppState createState() => _StickyHeaderSliverListAppState();
}

class _StickyHeaderSliverListAppState extends State<StickyHeaderSliverListApp> {
  List<Widget> _buildStickySliverList(int sliverListSize, int sliverChildCount) {
    var widgetList = List<Widget>();
    for (int index = 0; index < sliverListSize; index++) {
      widgetList
        ..add(
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text("Header $index"),
            pinned: true,
          ),
        )
        ..add(
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('Sublist item $index'),
              );
            }, childCount: sliverChildCount),
          ),
        );
    }

    return widgetList;
  }

  List<Widget> _buildStickySliverListTest(ListCount sliverList) {
    var widgetList = List<Widget>();
    for (int index = 0; index < sliverList.data.length; index++) {
      widgetList
        ..add(
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text("Header $index"),
            pinned: true,
          ),
        )
        ..add(
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('Sublist item \* $index'),
              );
            }, childCount: sliverList.data[index].length),
          ),
        );
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    var list1=["a","b","c"];
    var list2=["a","b","c","d","e"];
    var list3=["a","b"];
    var list4=["a","b","c","d"];
    var data=[list1,list2,list3,list4];
    var sliverList=ListCount(data);

    return Scaffold(
      appBar: AppBar(
        title: Text("Sticky Sliver List"),
      ),
      body: CustomScrollView(
//        slivers: _buildStickySliverList(20, 5),
      slivers: _buildStickySliverListTest(sliverList),
      ),
    );
  }
}

class ListCount{
  List<List<String>> data;

  ListCount(this.data);
}
