import 'package:flutter/material.dart';
import 'app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'start_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      supportedLocales: [
        Locale('en', 'USA'),
        Locale('ar', 'EGY'),
      ],
      localizationsDelegates: [
        //make sure localisation data is loaded at proper time
        AppLocalizations.delegate,
        GlobalMaterialLocalizations
            .delegate, //contains global words that are automatically translated (eg: cancel, ok, yes, no, etc)
        GlobalWidgetsLocalizations
            .delegate, //changes text direction from rtl or ltr
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: MyHomePage(),
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
      body: StartScreen(),
    );
  }
}
