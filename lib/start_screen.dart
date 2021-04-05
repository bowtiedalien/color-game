import 'package:colorgame/app_localizations.dart';
import 'package:colorgame/game.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

var currentScreen;

class StartScreen extends StatefulWidget {
  StartScreen();
  StartScreen.customConstructor(screenToShow) {
    currentScreen = screenToShow;
  }

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return currentScreen == 'Game3x3'
        ? Game(1)
        : currentScreen == 'Game4x4'
            ? Game(2)
            : currentScreen == 'Game5x5'
                ? Game(3)
                : Scaffold(
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
                          Text(
                              AppLocalizations.of(context)
                                  .translate('ChooseLevel'),
                              style: rockwellReg35),
                          Container(height: 20),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              setState(() {
                                print('clicked');
                                currentScreen = 'Game3x3';
                                print(currentScreen);
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
                              });
                            },
                            child: Container(
                              height: 110,
                              width: 155,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
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
                              });
                            },
                            child: Container(
                              height: 110,
                              width: 155,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
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
                        ],
                      ),
                    ),
                  );
  }
}

/* References:
- Gradients in Flutter using Container's BoxDecoration 
- https://www.geeksforgeeks.org/flutter-boxshadow-widget/
*/
