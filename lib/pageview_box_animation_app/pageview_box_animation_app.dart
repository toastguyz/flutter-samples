import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_samples/pageview_box_animation_app/notifying_pageview.dart';

class PageViewBoxAnimationApp extends StatefulWidget {
  @override
  _PageViewBoxAnimationAppState createState() =>
      _PageViewBoxAnimationAppState();
}

class _PageViewBoxAnimationAppState extends State<PageViewBoxAnimationApp> {
  ValueNotifier<double> _notifier;

  @override
  void dispose() {
    _notifier?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _notifier = ValueNotifier<double>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Drag and rotate!"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: NotifyingPageView(
                notifier: _notifier,
              ),
            ),
            Expanded(
              flex: 8,
              child: Center(
                child: AnimatedBuilder(
                  animation: _notifier,
                  builder: (context, _) {
                    return Transform.rotate(
                      angle: 2 * pi * _notifier.value,
                      child: Container(
                        color: Colors.redAccent,
                        width: 200,
                        height: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            Text(
                              "TOP",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
