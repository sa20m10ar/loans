import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:localization_3/services/preferences.dart';
import 'package:localization_3/screens/programs.dart';
import 'package:localization_3/screens/splash_screen.dart';
import 'package:localization_3/screens/favorite_programs.dart';
import 'package:localization_3/screens/help.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:localization_3/screens/on_boarding.dart';

void main() {
  return runApp(
    EasyLocalization(
      child: Start(),
      supportedLocales: [Locale('ar', 'DZ'),Locale('en', 'US')],
      fallbackLocale: Locale('ar', 'DZ'),
      path: 'assets',
      useOnlyLangCode: true,
      assetLoader: RootBundleAssetLoader(),

    ),
  );
}

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  @override
  void initState() {
    PrefService.controller.initPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    log(EasyLocalization.of(context).locale.toString(), name: this.toString());
    log(Intl.defaultLocale.toString(), name: this.toString());
//    var pref = PrefService.controller;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      title: 'Localization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => SplashScreen(),
        '/help': (BuildContext context) => HelpScreen(),
        '/onBoarding': (BuildContext context) => OnBoarding(),
        '/favoritePrograms': (BuildContext context) => FavoritePrograms(),
        '/programs': (BuildContext context) => Programs(),
      },
    );
  }
}
