import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUser extends StatefulWidget {
    @override
  _LoginUserState createState() => _LoginUserState();

}

class _LoginUserState extends State<LoginUser> {
  bool pref;
  TextEditingController username=new TextEditingController();
  TextEditingController password=new TextEditingController();
  var tgl=new DateTime.now();

  String _timeToString(DateTime now) {
    String timeString =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(
        2, '0')}:${now.second.toString().padLeft(2, '0')}";
    return timeString;
  }

  Future userLogin() async{
    String user=username.text;
    String pass=password.text;
    tgl=_timeToString(DateTime.now()) as DateTime;
    var url="http://192.168.1.12/tes_flutter/login.php";
    var response= await http.post(url, body: {
      "username": user,
      "password": pass,
      "time": tgl.toString()
    });
    var message=jsonDecode(response.body);
    if(message==1){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('boolValue', true);
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(
          msg: "Anda belum ada di database kami $user $pass",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
              ),
              Divider(),

              Container(
                width: 250,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Masukkan username"
                  ),
                ),
              ),

              Container(
                width: 250,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Masukkan password"
                  ),
                ),
              ),

              RaisedButton(
                child: new Text("Login"),
                color: Colors.cyanAccent,
                onPressed: userLogin,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

