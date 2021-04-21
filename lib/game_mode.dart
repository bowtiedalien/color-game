import 'package:colorgame/start_screen.dart';
import 'package:colorgame/styles.dart';
import 'package:flutter/material.dart';

import 'app_localizations.dart';

class GameMode extends StatefulWidget {
  @override
  _GameModeState createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context).translate('ChooseVersion'),
                style: rockwellReg35,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 20,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                //go to minimal mode (the one the prof wants)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StartScreen.customConstructor('home')));
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
                    AppLocalizations.of(context).translate('Minimal'),
                    style: rockwellReg30,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    //go to full-featured version (the one I added extra stuff to)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                StartScreen.customConstructor('home')));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2 - 77.5),
                    child: Container(
                      height: 110,
                      width: 155,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('FullFeatured'),
                          style: rockwellReg30,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Tooltip(
                  message:
                      "This is a more enhanced version with extra features like play/pause and ticking sound. However, it is not stable, and might be buggy.",
                  height: 30,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  padding: EdgeInsets.all(10),
                  textStyle: TextStyle(fontSize: 15, color: Colors.white),
                  showDuration: Duration(seconds: 30),
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Icon(Icons.help, size: 40, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
