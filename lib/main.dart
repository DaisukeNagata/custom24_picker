import 'package:custom24_picker/custom24_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var yearSt = '1990';
  var monthSt = '01';
  var datSt = '01';
  var hourSt = '01';
  var minutesSt = '00';

  void _incrementCounter() {
    setState(() {
      timePicker(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$yearSt/$monthSt/$datSt $hourSt:$minutesSt',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void timePicker(
    BuildContext context,
  ) {
    showCupertinoModalPopup<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  height: 521,
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 188, 188, 188),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 5.0,
                        ),
                        child: const Text(
                          'Completed',
                        ),
                      )
                    ],
                  ),
                ),
                _myPageBottomPicker(
                  Common24Picker(
                    backgroundColor: Colors.grey,
                    looping: true,
                    itemExtent: 32,
                    magnification: 1.1,
                    scrollControllers: [
                      /// TODO: scrollControllers set
                      FixedExtentScrollController(initialItem: 0),
                      FixedExtentScrollController(initialItem: 0),
                      FixedExtentScrollController(initialItem: 0),
                      FixedExtentScrollController(initialItem: 0),
                      FixedExtentScrollController(initialItem: 0),
                    ],
                    onSelectedItemChanged: (List<int> list) {
                      setState(() {
                        /// TODO: text set
                        if (list.last == 0) {
                          yearSt = '${list.first + 1990}';
                        } else if (list.last == 1) {
                          monthSt = '${list.first + 1}';
                        } else if (list.last == 2) {
                          datSt = '${list.first + 1}';
                        } else if (list.last == 3) {
                          hourSt = '${list.first + 1}';
                        } else if (list.last == 4) {
                          minutesSt = '${list.first}';
                        }
                      });
                    },
                    childDelegate: [
                      /// TODO: ListSet: text set and Delegate
                      ListWheelChildLoopingListDelegate(
                          children: listYearor(9, 2022)),
                      ListWheelChildLoopingListDelegate(children: _list(9, 12)),
                      ListWheelChildLoopingListDelegate(children: _list(9, 31)),
                      ListWheelChildLoopingListDelegate(children: _list(9, 24)),
                      ListWheelChildLoopingListDelegate(children: _list(9, 60)),
                    ],
                    children: [
                      /// TODO: ListSet: text set
                      listYearor(1989, 2022),
                      _list(9, 12),
                      _list(9, 31),
                      _list(9, 24),
                      _listMinutes(9, 60),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  List<Widget> _list(
    int start,
    int index,
  ) {
    return List<Widget>.generate(
      index,
      (int index) {
        return Center(
          child: Text(
            index < start ? '0${++index}' : (++index).toString(),
          ),
        );
      },
    );
  }

  List<Widget> _listMinutes(
    int start,
    int index,
  ) {
    return List<Widget>.generate(
      index,
      (int index) {
        return Center(
          child: Text(
            index <= start ? '0${++index - 1}' : (++index - 1).toString(),
          ),
        );
      },
    );
  }

  List<Widget> listYearor(
    int start,
    int index,
  ) {
    return List<Widget>.generate(
      index - start,
      (int index) {
        return Center(
          child: Text(
            (++index + start).toString(),
          ),
        );
      },
    );
  }

  Widget _myPageBottomPicker(Widget picker) {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          picker,
        ],
      ),
    );
  }
}
