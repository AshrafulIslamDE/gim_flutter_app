
class MyTimer {
  MyTimer._privateConstructor();

  static final MyTimer _instance = MyTimer._privateConstructor();

  static MyTimer get instance { return _instance;}

  var _elapsedTime = 0;
  var _counter = 0;

  get seconds {
    return _counter ~/ 1000;
  }

  int getTimeInSeconds() {
    return _counter ~/ 1000;
  }

  startTimer() {
    _counter = 0;
    _elapsedTime = DateTime.now().millisecondsSinceEpoch;
  }

  stopTimer() {
    var diff = DateTime.now().millisecondsSinceEpoch - _elapsedTime;
    _counter += diff;
  }

  pauseTimer() {
    var diff = DateTime.now().millisecondsSinceEpoch - _elapsedTime;
    _counter += diff;
    print("diff ${diff/1000}");
  }

  resumeTimer() {
    _elapsedTime = DateTime.now().millisecondsSinceEpoch;
  }
}
