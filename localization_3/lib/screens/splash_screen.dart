import 'dart:async';

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:localization_3/services/preferences.dart';

import 'package:localization_3/screens/home.dart';
import 'package:localization_3/screens/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var pref = PrefService.controller;


  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            pref.visitingState == false ? OnBoarding() : HomePage()));
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/lo.png',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    "splashText",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25.0),
                  ).tr(context: context),
                )
              ],
            ),
          ),
        ),
      );
  }
}
