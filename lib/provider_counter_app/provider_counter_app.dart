import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/provider_counter_app/provider_counter_bloc.dart';
import 'package:provider/provider.dart';

class ProviderCounterApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProviderBloc providerBloc = Provider.of<ProviderBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Sample"),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text("${providerBloc.counter}",style: TextStyle(fontSize: 50.0),),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 0,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              providerBloc.increment();
            },
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            heroTag: 1,
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {
              providerBloc.decrement();
            },
          ),
        ],
      ),
    );
  }
}
