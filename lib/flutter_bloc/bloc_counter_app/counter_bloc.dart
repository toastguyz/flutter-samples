import 'dart:async';

import 'package:flutter_samples/flutter_bloc/bloc_counter_app/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

  // for state, exposing only a stream which outputs the data.
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();

// for event, exposing only a sink which is an input.
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    //Whenever there is an new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
