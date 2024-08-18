import 'package:colorgame/models/timer.dart';
import 'package:flutter/material.dart';
import './app_localizations.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import './screens/game_mode.dart';
import 'package:provider/provider.dart';

import 'routes/custom_router.dart';
import 'routes/route_names.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      print('changing locale in appstate');
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimerModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        locale: _locale,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'EGY'),
        ],
        localizationsDelegates: [
          //make sure localisation data is loaded at proper time
          AppLocalizations.delegate,
          GlobalMaterialLocalizations
              .delegate, //contains global words that are automatically translated (eg: cancel, ok, yes, no, etc)
          GlobalWidgetsLocalizations
              .delegate, //changes text direction from rtl or ltr
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        onGenerateRoute: CustomRouter.allRoutes,
        initialRoute: homeRoute,
        //home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //if Scaffold is not used as the topmost widget, I get yellow lines under text
      body: GameMode(),
    );
  }
}
