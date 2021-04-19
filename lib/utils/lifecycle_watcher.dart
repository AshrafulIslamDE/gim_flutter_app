
import 'package:customer/utils/my_timer.dart';
import 'package:flutter/cupertino.dart';

class LifecycleWatcher extends StatefulWidget {
  const LifecycleWatcher({ Key key }) : super(key: key);

  @override
  _LifecycleWatcherState createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with
    WidgetsBindingObserver {

  AppLifecycleState _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
      debugPrint("##### didChangeAppLifecycleState $state");

      if(state == AppLifecycleState.paused) {
        MyTimer.instance.pauseTimer();
        var seconds = MyTimer.instance.getTimeInSeconds();
        debugPrint("##### didChangeAppLifecycleState paused $seconds");

      }

      if(state == AppLifecycleState.resumed) {
        MyTimer.instance.resumeTimer();
        debugPrint("##### didChangeAppLifecycleState resumed");

      }

    });
  }

  @override
  Widget build(BuildContext context) {
    if (_appLifecycleState == null)
      return const Text('This widget has not observed any lifecycle changes.');
    return Text('The most recent lifecycle state this widget observed was: '
        '$_appLifecycleState.');
  }
}