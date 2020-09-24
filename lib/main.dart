import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(title: Text('Home')),
        body: Center(
        child: SimpleClock()
        ),
      )
    );
  }
}

class SimpleClock extends StatefulWidget {
    @override
  _SimpleClockState createState() => _SimpleClockState();
}

class _SimpleClockState extends State<SimpleClock> {

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('boolValue');
    return boolValue;
  }

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', true);
  }

  String _now;
  Timer _everySecond;

  @override
  void initState() {
    super.initState();
    //addBoolToSF();
    bool tes=true;
    if(tes){
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context)=>
            new LoginUser(),
          ));
    }
    _now = _timeToString(DateTime.now());
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!mounted) return;
      setState(() {
        _now = _timeToString(DateTime.now());
      });
    });
  }

  String _timeToString(DateTime now) {
    String timeString =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(
        2, '0')}:${now.second.toString().padLeft(2, '0')}";
    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(_now,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ))),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(""),
              )
          ],
        )
    )
    )
    );
  }
}