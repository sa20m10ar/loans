import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:localization_3/services/api.dart';
import 'package:localization_3/models/home_model.dart';
import 'package:localization_3/models/program_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentLang;

  final ProgramHelper helper = ProgramHelper();

  var api = Api();
  List<Datum> mData;

  Future<bool> getHomeData(currentLag) async {
    var response = await api.home(currentLag);
    Home model = Home.fromJson(response.data);
    mData = model.data;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    currentLang = EasyLocalization.of(context).locale.languageCode;
    Locale locale;
    return FutureBuilder(
      future: getHomeData(currentLang),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
              appBar: AppBar(),
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        "drawerName",
                        style: TextStyle(color: Colors.black),
                      ).tr(context: context),
                      accountEmail: Text(
                        "drawerSub",
                        style: TextStyle(color: Colors.black),
                      ).tr(context: context),
                      currentAccountPicture: Image.asset(
                        'assets/images/lo.png',
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    ListTile(
                      title: Text("programs").tr(context: context),
                      leading: Icon(Icons.chat),
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.of(context).pushNamed('/programs');
                      },
                    ),
                    ListTile(
                      title: Text("favoritePrograms").tr(context: context),
                      leading: Icon(Icons.favorite),
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed('/favoritePrograms');
                      },
                    ),
                    ListTile(
                      title: Text("listTile1").tr(context: context),
                      leading: Icon(Icons.help),
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.of(context).pushNamed('/help');
                      },
                    ),
                    ListTile(
                      title: Text("listTile2").tr(context: context),
                      leading: Icon(Icons.language),
                      onTap: () {
                        if (EasyLocalization.of(context).locale.languageCode ==
                            "en") {
                          locale = Locale("ar", "DZ");
                          log(locale.toString(), name: this.toString());

                          EasyLocalization.of(context).locale = locale;
                        } else {
                          locale = Locale("en", "US");

                          log(locale.toString(), name: this.toString());

                          EasyLocalization.of(context).locale = locale;
                        }
                        //Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              body: ListView.builder(
                itemCount: mData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 20, bottom: 20),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.5, 0.5))
                                    ]),
                                child: Padding(
                                  padding: currentLang == "en"
                                      ? EdgeInsets.only(left: 140)
                                      : EdgeInsets.only(right: 140),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        mData[index].value,
                                        // tr('cardHeader'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        mData[index].value,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.5, 0.5))
                                    ],
                                    border:
                                        Border.all(style: BorderStyle.solid),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/test.jpg',
                                        ),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              bottom: 50,
                              left: currentLang == "en" ? 5 : 250,
                              width: 150,
                              height: 100,
                            )
                          ],
                          overflow: Overflow.visible,
                        ),
                      ],
                    ),
                  );
                },
              ));
        }
      },
    );
  }
}
