import 'dart:async';
import 'dart:math';
import 'package:colorgame/app_localizations.dart';
import 'package:colorgame/start_screen.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

class Game extends StatefulWidget {
  int levelNumber;
  Game(level) {
    levelNumber = level;
  }

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 60;
  Timer _timer;
  bool showStartDialogBool = true;
  // Widget _randomColorGrid;
  Color correctColor;

  List<Color> randomColors = [
    // Colors.primaries[Random().nextInt(Colors.primaries.length)],
    // Colors.primaries[Random().nextInt(Colors.primaries.length)],
    // Colors.primaries[Random().nextInt(Colors.primaries.length)],
    // Colors.primaries[Random().nextInt(Colors.primaries.length)],
    // Colors.primaries[Random().nextInt(Colors.primaries.length)],
    // Colors.primaries[Random().nextInt(Colors.primaries.length)],
    // Colors.primaries[Random().nextInt(Colors.primaries.length)],
    // Colors.primaries[Random().nextInt(Colors.primaries.length)],
    // Colors.primaries[Random().nextInt(Colors.primaries.length)]
  ];
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

  void startTimer() {
    print('timer started');
    _counter = 60;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  onContainerClicked(Color id, BuildContext contex) async {
    // print('Container $id was clicked');
    if (id == correctColor) {
      print('CORRECT CHOICE');
      // showWinDialog(contex);
      await showDialog(
        context: contex,
        builder: (_) => showWinDialog(contex),
      );
      setState(() {
        _counter = 60;
        randomColors.clear();
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
        builder: (_) => showLoseDialog(contex),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();

    /*Initialise correct color */
    var rnd = new Random();
    // correctColor = 0 + rnd.nextInt(9 - 0);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              bottom: 0.0,
              // top: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                            MediaQuery.of(context).size.width),
              ),
            ),
            Positioned(
              top: 0.0,
              child: Container(
                padding: EdgeInsets.only(top: 20),
                // margin: EdgeInsets.only(bottom: 130),
                // constraints: BoxConstraints.expand(),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5), blurRadius: 5)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate('Time') +
                                ':',
                            style: montserratSemiBold35,
                          ),
                          Text(
                            _counter.toString(),
                            style: TextStyle(fontSize: 35),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                    .translate('NextColor') +
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
                ),
              ),
            ),
            // if (showStartDialogBool == true)
            //   {
            //     showDialog(
            //       context: context,
            //       builder: (_) => showStartDialog(context),
            //     )
            //   },
          ],
        ),
      ),
    );
  }

//Not used
  // Widget showStartDialog(context) {
  //   return AlertDialog(
  //     content: Text("Ready to start game?"),
  //     actions: [
  //       IconButton(
  //         icon: Icon(Icons.arrow_back_rounded),
  //         onPressed: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (_) => StartScreen()));
  //         },
  //       ),
  //       IconButton(
  //         icon: Icon(Icons.play_circle_filled),
  //         onPressed: () {
  //           Navigator.of(context, rootNavigator: true).pop('dialog');
  //           // showStartDialogBool = false;
  //           // Navigator.pop(context);
  //         },
  //       )
  //     ],
  //   );
  // }
}

Widget showWinDialog(context) {
  return AlertDialog(
    title: Text("You won!!!"),
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
  return AlertDialog(
    title: Text("You lose ..."),
    actions: [
      IconButton(
        icon: Icon(
          Icons.sentiment_very_dissatisfied_rounded,
          color: Colors.blue,
          size: 40,
        ),
        onPressed: () {
          // Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => StartScreen.customConstructor('')));
        },
      )
    ],
  );
}
