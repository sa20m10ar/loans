import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:localization_3/services/preferences.dart';
import 'package:localization_3/services/api.dart';
import 'package:localization_3/screens/home.dart';
import 'package:localization_3/models/model.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var imageIndex = 0;
  var mController = SwiperController();

  var api = Api();
  var pref = PrefService.controller;

  List<Help> help;

  String currentLag;

  Future<bool> getPosts(String lang) async {
    var response = await api.posts(lang);
    Localize model = Localize.fromJson(response.data);
    help = model.data.help;
    return true;
  }
  bool isChanged = false;
  onChangeButton(){
    setState(() {
      isChanged = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    currentLag = EasyLocalization.of(context).locale.languageCode;

    return FutureBuilder(
          future: getPosts(currentLag),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 320,
                      child: Swiper(
                        itemWidth: MediaQuery.of(context).size.width,
                        itemCount: help.length,
                        index: imageIndex,
                        controller: mController,
                        itemBuilder: (context, index) {
                          return Image.network(
                            "http://loans.neoxero.com/${help[index].image}",
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: new SwiperPagination(),
                        onIndexChanged: (index) {
                          setState(() {
                            imageIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15),
                      child: Text(
                        help[imageIndex].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Text(help[imageIndex].content),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 5),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ]),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Color(0xff1c9a98),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    if ( help.length -  1 == imageIndex  ) {
                      onChangeButton();
                      Future.delayed(
                          Duration(seconds: 4),).then((_){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        pref.visitingState =true;

                      });

                    } else {
                      setState(() {
                        mController.next();
                      });
                    }
                  },
                  child: isChanged
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text(
                    "nextButton",
                    //style: TextStyle(color: is darl : assfa : ascas),
                        ).tr(context:context),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
              );
            }
          });
  }
}
