import 'dart:math';

import 'package:colorgame/routes/route_names.dart';
import 'package:colorgame/screens/game_over.dart';
import '../screens/start_screen.dart';
import '../styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_localizations.dart';

import '../models/timer.dart';
import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  final levelNumber;
  Game(this.levelNumber);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Color? correctColor;
  List<Color> randomColors = [];
  int? _score = 0;
  Future<int?> _getScoreFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _score = prefs.getInt('score');
    if (_score == null) {
      return 0;
    }
    return _score;
  }

  Future<void> _resetScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', 0);
  }

  @override
  void initState() {
    super.initState();

    //Step 2: initialise the color grids for the first time
    if (widget.levelNumber == 1) {
      for (var i = 0; i < 9; i++) {
        randomColors
            .add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
      }
      correctColor = randomColors[Random().nextInt(9)];
    } else if (widget.levelNumber == 2) {
      for (var i = 0; i < 16; i++) {
        randomColors
            .add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
      }
      correctColor = randomColors[Random().nextInt(16)];
    } else {
      for (var i = 0; i < 25; i++) {
        randomColors
            .add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
      }
      correctColor = randomColors[Random().nextInt(25)];
    }

    //Step 3: Reset the score
    _resetScore();
  }

  Widget showWinDialog(context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.translate('Yay')!),
      content: Text(
        AppLocalizations.of(context)!.translate('Score')! +
            " : " +
            _score.toString(),
        style: montserratSemiBold35,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.celebration,
            color: Colors.orange,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
        )
      ],
    );
  }

  Widget showLoseDialog(context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)!.translate('YouLost')!),
        content: Text(
            AppLocalizations.of(context)!.translate('Score')! +
                " : " +
                _score.toString(),
            style: montserratSemiBold35),
        actions: [
          IconButton(
            icon: Icon(
              Icons.sentiment_very_dissatisfied_rounded,
              color: Colors.blue,
              size: 40,
            ),
            onPressed: () {
              var finalScore = _score;
              setState(() {
                _resetScore();
              });
              Navigator.pushNamed(context, '/gameOver',
                  arguments: GameOver(
                    finalScore,
                    timeIsUp: false,
                  ));
            },
          )
        ],
      ),
    );
  }

  onContainerClicked(Color id, BuildContext contex) async {
    if (id == correctColor) {
      await _incrementScore();
      _getScoreFromPrefs();
      print('CORRECT CHOICE');
      await showDialog(
        context: contex,
        builder: (_) => showWinDialog(context),
      );
      setState(() {
        randomColors.clear();

        // refresh the color grids after user wins
        if (widget.levelNumber == 1) {
          for (var i = 0; i < 9; i++) {
            randomColors.add(
                Colors.primaries[Random().nextInt(Colors.primaries.length)]);
          }
          correctColor = randomColors[Random().nextInt(9)];
        } else if (widget.levelNumber == 2) {
          for (var i = 0; i < 16; i++) {
            randomColors.add(
                Colors.primaries[Random().nextInt(Colors.primaries.length)]);
          }
          correctColor = randomColors[Random().nextInt(16)];
        } else {
          for (var i = 0; i < 25; i++) {
            randomColors.add(
                Colors.primaries[Random().nextInt(Colors.primaries.length)]);
          }
          correctColor = randomColors[Random().nextInt(25)];
        }
      });
    } else {
      await showDialog(
        context: contex,
        barrierDismissible: false,
        builder: (_) => showLoseDialog(contex),
      );
    }
  }

  Widget colorGrid(context, double h, double wid) {
    return SizedBox(
      height: h,
      width: wid,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              return GestureDetector(
                onTap: () => onContainerClicked(randomColors[index], context),
                child: Container(
                  color: randomColors[index],
                ),
              );
            })),
      ),
    );
  }

  Widget colorGrid4x4(context, double h, double wid) {
    return SizedBox(
      height: h,
      width: wid,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(16, (index) {
              return GestureDetector(
                onTap: () => onContainerClicked(randomColors[index], context),
                child: Container(
                  color: randomColors[index],
                ),
              );
            })),
      ),
    );
  }

  Widget colorGrid5x5(context, double h, double wid) {
    return SizedBox(
      height: h,
      width: wid,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GridView.count(
            crossAxisCount: 5,
            children: List.generate(25, (index) {
              return GestureDetector(
                onTap: () => onContainerClicked(randomColors[index], context),
                child: Container(
                  color: randomColors[index],
                ),
              );
            })),
      ),
    );
  }

  Future<void> _incrementScore() async {
    final prefs = await SharedPreferences.getInstance();
    int? lastScore = await _getScoreFromPrefs();
    int currentScore = lastScore != null ? lastScore += 5 : 0;

    await prefs.setInt('score', currentScore);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Exit the Game'),
            content: new Text('Are you sure you want to exit the game?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, homeRoute),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<TimerModel>(context).counter;

    return counter == 0
        ? StartScreen(
            currentScreen: 'Game Over',
            timeWasUp: true,
            finalScore: _score,
          )
        : WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: Container(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0.0,
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5)
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                                  .translate('Time')! +
                                              ':',
                                          style: montserratSemiBold35,
                                        ),
                                        Consumer<TimerModel>(
                                          builder: (context, time, child) {
                                            return Text(
                                              time.counter.toString(),
                                              style: TextStyle(fontSize: 35),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                                  .translate('NextColor')! +
                                              ':',
                                          style: montserratSemiBold35,
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          height: 43,
                                          width: 53,
                                          color: correctColor,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0.0,
                        child: widget.levelNumber == 1
                            ? colorGrid(
                                context,
                                MediaQuery.of(context).size.height / 1.8,
                                MediaQuery.of(context).size.width)
                            : widget.levelNumber == 2
                                ? colorGrid4x4(
                                    context,
                                    MediaQuery.of(context).size.height / 1.8,
                                    MediaQuery.of(context).size.width)
                                : colorGrid5x5(
                                    context,
                                    MediaQuery.of(context).size.height / 1.8,
                                    MediaQuery.of(context).size.width)),
                  ],
                ),
              ),
            ),
          );
  }
}
