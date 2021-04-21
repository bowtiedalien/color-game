import 'package:flutter/material.dart';
import 'app_localizations.dart';
import 'start_screen.dart';
import 'styles.dart';

class GameOver extends StatefulWidget {
  bool timeIsUp = false;
  int finalScore;
  GameOver(this.finalScore, {this.timeIsUp});
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
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
        // padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.timeIsUp
                ? Text(AppLocalizations.of(context).translate('TimeIsUp'),
                    style: montserratSemiBold35)
                : null,
            Container(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context).translate('Score') +
                  ':' +
                  widget.finalScore.toString(),
              style: ralewaySemiBold35,
            ),
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => StartScreen.customConstructor('')));
                },
                child: Text(
                  AppLocalizations.of(context).translate('BackToMainScreen'),
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
