import 'dart:math';
import 'package:colorgame/app_localizations.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                // mask container -- transparent
                height: MediaQuery.of(context).size.height - 500,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                bottom: 0.0,
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45.0),
                      bottomRight: Radius.circular(45.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff707070),
                        offset: Offset(0, 3),
                        blurRadius: 6.0,
                      ),
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
                              '60',
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
                              color: Colors.red,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: colorGrid(MediaQuery.of(context).size.height,
                MediaQuery.of(context).size.width),
          ),
        ],
      ),
    );
  }
}

Widget colorGrid(double h, double wid) {
  return SizedBox(
    height: h,
    width: wid,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Container(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            );
          })),
    ),
  );
}
