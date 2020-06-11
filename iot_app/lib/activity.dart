import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class Activity extends StatefulWidget {
  @override
  _MyActivity createState() => _MyActivity();
}

class _MyActivity extends State<Activity> {
  String ip_address;
  List<bool> isSelected = [false];
  double posx, posy, posz, azimuth, roll, pitch;
  List<double> _accelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    ip_address = ModalRoute.of(context).settings.arguments;
    if (isSelected[0]) {
      postData(_accelerometerValues[0], _accelerometerValues[1],
          _accelerometerValues[2], _gyroscopeValues[0], _gyroscopeValues[1],
          _gyroscopeValues[2]);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("IOT App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ToggleButtons(
                  children: [
                    Icon(Icons.flash_on, color: Colors.deepOrangeAccent),
                  ],
                  selectedColor: Colors.blue,
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      isSelected[index] = !isSelected[index];
                    });
                    if (isSelected[index]) {
                      ledOn(ip_address);
                    }
                    else {
                      ledOff(ip_address);
                    }
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Text('Enable', style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void ledOff(String ip) async{
    String url = ip_address + "/off";
    await http.get(url);
  }

  void ledOn(String ip) async{
    String url = ip_address + "/on";
    await http.get(url);
  }

  void postData(double accX, double accY, double accZ,
      double rotX, double rotY, double rotZ) async {
    String query = "?accX=$accX&accY=$accY&accZ=$accZ,rotX=$rotX&rotY=$rotY&rotZ=$rotZ";
    String url = ip_address + "/post" + query;
    await http.get(url);
  }
}