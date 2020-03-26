import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:wifi_hunter/wifi_hunter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer _timer;
  WiFiInfoWrapper _wifiObject;
  Future<WiFiInfoWrapper> scanWiFi() async {
    WiFiInfoWrapper wifiObject;

    try {
      wifiObject = await WiFiHunter.huntRequest;
    } on PlatformException {}

    return wifiObject;
  }

  Future<void> scanHandler() async {
    _wifiObject = await scanWiFi();
    print("WiFi Results (SSIDs) : ");
    for (var i = 0; i < _wifiObject.ssids.length; i++) {
      print(i);
      print(_wifiObject.ssids[i]);
      print(_wifiObject.signalStrengths[i]);
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(Duration(seconds: 3), (timer) {
      scanHandler();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("WiFiScanner"),
        ),
        // body: Column(
        //   children: <Widget>[
        //     FlatButton(
        //       child: Text("StartScanner"),
        //       onPressed: () {
        //         _timer = new Timer.periodic(Duration(seconds: 3), (timer) {
        //           scanHandler();
        //         });
        //       },
        //     ),
        //     FlatButton(
        //       child: Text("StopScanner"),
        //       onPressed: () {
        //         _timer.cancel();
        //       },
        //     )
        //   ],
        // ),
      ),
    );
  }
}
