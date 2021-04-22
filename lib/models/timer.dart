import 'package:flutter/foundation.dart';
import 'dart:async';

class TimerModel extends ChangeNotifier {
  int _counter = 60;
  late Timer _timer;

  set counter(v) => _counter = v;
  get counter => _counter;

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        _counter--;
      } else {
        _timer.cancel();
      }
      notifyListeners();
    });
  }
}
