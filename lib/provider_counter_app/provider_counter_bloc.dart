import 'package:flutter/material.dart';

class ProviderBloc with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  set counter(int val) {
    _counter = val;
    notifyListeners();
  }

  increment() {
    counter = counter + 1;
  }

  decrement() {
    counter = counter - 1;
  }
}
