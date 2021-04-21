import 'package:colorgame/app_localizations.dart';
import 'package:colorgame/game.dart';
import 'package:colorgame/game_fullfeatured.dart';
import 'classes/language.dart';
import 'game_over.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'models/timer.dart';
import 'styles.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StartScreen extends StatefulWidget {
  //optional variables
  bool timeWasUp = false;
  int finalScore;
  int mode;
  var currentScreen;
  //------------------------
  StartScreen({this.currentScreen, this.finalScore, this.timeWasUp, this.mode});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(language.languageCode, 'EGY');
        break;
      default:
        _temp = Locale(language.languageCode, 'US');
    }

    MyApp.setLocale(context, _temp);
  }

  var currentScreen;
  @override
  Widget build(BuildContext context) {
    //init gameScreen type and init currentScreen
    Widget gameScreen(level) {
      if (widget.mode == 2) return GameV2(level);
      return Game(level); //default
    }

    currentScreen = widget.currentScreen;

    return currentScreen == 'Game3x3'
        ? gameScreen(1)
        : currentScreen == 'Game4x4'
            ? gameScreen(2)
            : currentScreen == 'Game5x5'
                ? gameScreen(3)
                : currentScreen == 'Game Over'
                    ? GameOver(
                        widget.finalScore,
                        timeIsUp: widget.timeWasUp,
                      )
                    : Scaffold(
                        extendBodyBehindAppBar: true,
                        drawer: Drawer(
                          child: ListView(
                            children: Language.languageList().map((lang) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ListTile(
                                  leading: Text(
                                    lang.flag,
                                    style: TextStyle(fontSize: 35),
                                  ),
                                  title: Text(lang.name,
                                      style: TextStyle(fontSize: 35)),
                                  onTap: () {
                                    _changeLanguage(lang);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        appBar: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                        body: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xffF65130),
                                Color(0xffE9941A),
                              ],
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 200,
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('ChooseLevel'),
                                    style: rockwellReg35,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(height: 20),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      print('clicked');
                                      currentScreen = 'Game3x3';
                                      print(currentScreen);

                                      //reset the counter
                                      Provider.of<TimerModel>(context,
                                              listen: false)
                                          .counter = 60;

                                      //start the timer
                                      Provider.of<TimerModel>(context,
                                              listen: false)
                                          .startTimer();
                                    });
                                  },
                                  child: Container(
                                    height: 110,
                                    width: 155,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff0000),
                                            offset: Offset(0, 3),
                                            blurRadius: 6.0,
                                          ),
                                        ]),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '3x3',
                                        style: rockwellReg60,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(height: 20),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      print('clicked');
                                      currentScreen = 'Game4x4';
                                      print(currentScreen);

                                      //reset the counter
                                      Provider.of<TimerModel>(context,
                                              listen: false)
                                          .counter = 60;

                                      //start the timer
                                      Provider.of<TimerModel>(context,
                                              listen: false)
                                          .startTimer();
                                    });
                                  },
                                  child: Container(
                                    height: 110,
                                    width: 155,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '4x4',
                                        style: rockwellReg60,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(height: 20),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      print('clicked');
                                      currentScreen = 'Game5x5';
                                      print(currentScreen);

                                      //reset the counter
                                      Provider.of<TimerModel>(context,
                                              listen: false)
                                          .counter = 60;

                                      //start the timer
                                      Provider.of<TimerModel>(context,
                                              listen: false)
                                          .startTimer();
                                    });
                                  },
                                  child: Container(
                                    height: 110,
                                    width: 155,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '5x5',
                                        style: rockwellReg60,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      );
  }
}

/* References:
- Gradients in Flutter using Container's BoxDecoration 
- https://www.geeksforgeeks.org/flutter-boxshadow-widget/
*/
