import 'package:colorgame/models/timer.dart';
import 'package:colorgame/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:colorgame/screens/start_screen.dart';
import 'package:flutter/material.dart';
import '../app_localizations.dart';
import '../styles.dart';

// ignore: must_be_immutable
class GameOver extends StatefulWidget {
  bool? timeIsUp = false;
  int? finalScore;
  int? gameLevel;
  GameOver(this.finalScore, {this.timeIsUp, this.gameLevel});
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    int finalScore = widget.finalScore ?? 0;
    int gameLevel = widget.gameLevel ?? 1;
    String gameLevelString = gameLevel == 1
        ? 'Game3x3'
        : gameLevel == 2
            ? 'Game4x4'
            : 'Game5x5';

    return Scaffold(
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
        margin: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.timeIsUp!
                ? Text(AppLocalizations.of(context)!.translate('TimeIsUp')!,
                    style: montserratSemiBold35)
                : Text(''),
            Container(
              height: 20,
            ),
            Container(
              width: 305,
              height: 60,
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0, 3),
                      blurRadius: 5),
                ],
              ),
              child: Text(
                AppLocalizations.of(context)!.translate('Score')! +
                    ': ' +
                    finalScore.toString(),
                textAlign: TextAlign.center,
                style: ralewaySemiBold35,
              ),
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  primary: Color(0xff07A9F4),
                  onPrimary: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, startScreenRoute,
                      arguments: StartScreen(currentScreen: gameLevelString));

                  Provider.of<TimerModel>(context, listen: false).counter =
                      60; //reset counter
                },
                child: Text(
                  AppLocalizations.of(context)!.translate('TryAgain')!,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),

            //Back to Main Screen Button
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  primary: Color(0xff2EC261),
                  onPrimary: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, startScreenRoute);
                },
                child: Text(
                  AppLocalizations.of(context)!.translate('BackToMainScreen')!,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
