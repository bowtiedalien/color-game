import 'dart:async';
import 'dart:math';
import 'package:colorgame/app_localizations.dart';
import 'package:colorgame/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class GameV2 extends StatefulWidget {
  int levelNumber;
  GameV2(level) {
    levelNumber = level;
  }

  @override
  _GameV2State createState() => _GameV2State();
}

class _GameV2State extends State<GameV2> {
  int _counter = 60;
  Timer _timer;
  bool volumeIsOn = true;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  AudioCache audioCache;
  String path =
      'tiktok.mp3'; //todo: try changing this to "sounds/tiktok" and removing the assets/tiktok from the file tree and check if it works. Also try vice versa.
  bool _timerPaused = false;
  bool showStartDialogBool = true;
  Color correctColor;
  int _score = 0;

  Future<int> _getScoreFromPrefs() async {
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

  Future<void> _incrementScore() async {
    final prefs = await SharedPreferences.getInstance();
    int lastScore = await _getScoreFromPrefs();
    int currentScore = lastScore + 5;

    await prefs.setInt('score', currentScore);
  }

  List<Color> randomColors = []; //I initialise this in initState

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

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          audioPlayerState = AudioPlayerState.STOPPED;
          _timer.cancel();
        }
      });
    });
    _timerPaused = false;
  }

  void stopTimer() {
    print('stopped timer');
    _timerPaused = true;
    audioPlayerState = AudioPlayerState.PAUSED;
    if (_timer != null) _timer.cancel();
  }

  onContainerClicked(Color id, BuildContext contex) async {
    if (id == correctColor) {
      await _incrementScore();
      print('CORRECT CHOICE');
      await showDialog(
        context: contex,
        builder: (_) => showWinDialog(contex),
      );
      setState(() {
        _counter = 60;
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
        builder: (_) => showLoseDialog(contex),
      );
    }
  }

  playMusic() async {
    // print('playing music..');
    await audioCache.play(path);

    if (_timerPaused) {
      audioPlayerState = AudioPlayerState.STOPPED;
    }
  }

  pauseMusic() async {
    // print('pausing music..');
    await audioPlayer.pause();
  }

  @override
  void initState() {
    super.initState();

    audioCache = AudioCache(fixedPlayer: audioPlayer);
    //-- This is causing the tiktok to keep playing even after game is over
    //--- Also, it is causing an error:
    //---- [ERROR:flutter/lib/ui/ui_dart_state.cc(186)] Unhandled Exception: setState() called after dispose(): _GameState#7111f(lifecycle state: defunct, not mounted)
    // audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
    //   if (this.mounted) {
    //     setState(() {
    //       audioPlayerState = s;
    //     });
    //   }
    // });

    _incrementScore();

    if (_timerPaused == false) {
      startTimer();
    }

    // initialise the color grids for the first time
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
  void dispose() {
    super.dispose();

    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();
    _timer.cancel();
  }

  Widget showWinDialog(context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('Yay')),
      content: Text(
        AppLocalizations.of(context).translate('Score') +
            " : " +
            _score.toString(),
        style: montserratSemiBold35,
        // style: ralewaySemiBold35),
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
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('YouLost')),
      content: Text(
          AppLocalizations.of(context).translate('Score') +
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
            setState(() {
              _resetScore();
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => StartScreen(
                        currentScreen: 'home'))); // go back to home screen
          },
        )
      ],
    );
  }

//not used
  Widget showTimeUpDialog(context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('YouLost')),
      content: Text(AppLocalizations.of(context).translate('TimeIsUp'),
          style: montserratSemiBold35),
      actions: [
        IconButton(
          icon: Icon(
            Icons.lock_clock,
            color: Colors.blue,
            size: 40,
          ),
          onPressed: () {
            setState(() {
              _resetScore();
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => StartScreen(
                        currentScreen: 'home'))); // go back to home screen
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (volumeIsOn) playMusic();
    return _counter == 0
        ? StartScreen(currentScreen: 'Game Over')
        : Scaffold(
            body: Container(
              child: Stack(children: [
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // width: 210,
                            width: MediaQuery.of(context).size.width - 170,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                              .translate('Time') +
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.volume_off_rounded, size: 20),
                                onPressed: () {
                                  setState(() {
                                    volumeIsOn = false;
                                  });
                                },
                              ),
                              IconButton(
                                  icon: Icon(
                                      _timerPaused
                                          ? Icons.play_circle_filled_outlined
                                          : Icons.pause_circle_filled_outlined,
                                      size: 35),
                                  onPressed: () {
                                    setState(() {
                                      _timerPaused ? startTimer() : stopTimer();
                                    });
                                  }),
                              IconButton(
                                icon:
                                    Icon(Icons.exit_to_app_outlined, size: 35),
                                onPressed: () {
                                  setState(() {
                                    _timerPaused =
                                        true; //don't know if this would throw an error
                                  });
                                  audioPlayerState = AudioPlayerState.STOPPED;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => StartScreen(
                                              currentScreen: 'home')));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
  }
}
