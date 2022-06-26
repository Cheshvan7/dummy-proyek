import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

void main() {
  runApp(const alarm());
}

class alarm extends StatefulWidget {
  const alarm({Key? key}) : super(key: key);

  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> {
  TextEditingController jamController = TextEditingController();
  TextEditingController menitController = TextEditingController();
  int jam = 0;
  int menit = 0;
  TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;

  Future<Null> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    setState(() {
      _time = picked;
      String j = _time.hour.toString();
      String m = _time.minute.toString();
      jam = int.parse(j);
      menit = int.parse(m);
      print(picked);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                ),
                Icon(
                  Icons.alarm,
                  size: 100,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      selectTime(context);
                    },
                    child: Text(
                      "Atur Alarm",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: 250,
              margin: const EdgeInsets.all(25),
              child: ElevatedButton(
                child: const Text(
                  'Create alarm',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  FlutterAlarmClock.createAlarm(jam, menit,
                      title: "Waktunya Olahraga");
                },
              ),
            ),
          ],
        ),
      )
          // Container(
          //   margin: const EdgeInsets.all(25),
          //   child: TextButton(
          //     child: const Text(
          //       'Set Alarm',
          //       style: TextStyle(fontSize: 20.0),
          //     ),
          //     onPressed: () {
          //       int jam;
          //       int menit;
          //       jam = int.parse(jamController.text);
          //       menit = int.parse(menitController.text);
          //       FlutterAlarmClock.createAlarm(jam, menit);
          //     },
          //   ),
          // ),
          ),
    );
  }
}
