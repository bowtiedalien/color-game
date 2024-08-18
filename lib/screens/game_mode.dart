import 'package:colorgame/models/timer.dart';
import 'package:colorgame/routes/route_names.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../screens/start_screen.dart';
import '../styles.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

class GameMode extends StatefulWidget {
  @override
  _GameModeState createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(AppLocalizations.of(context)!
                .translate('ExitGameDialogTitle')!),
            content: new Text(
                AppLocalizations.of(context)!.translate('ExitGameDialogText')!),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(AppLocalizations.of(context)!.translate('No')!),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); //exit app

                  //not sure if this is necessary, but keeping it in case the timer does not dispose itself
                  //after exiting app to avoid possible problems.
                  Provider.of<TimerModel>(context, listen: false).stopTimer();
                },
                child:
                    new Text(AppLocalizations.of(context)!.translate('Yes')!),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    GlobalKey _tooltipKey = GlobalKey();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                  AppLocalizations.of(context)!.translate('ChooseVersion')!,
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
                  Navigator.pushNamed(context, startScreenRoute,
                      arguments: StartScreen(
                        currentScreen: 'home',
                        mode: 1,
                      ));
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
                      AppLocalizations.of(context)!.translate('Minimal')!,
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
                      // Navigator.pushNamed(context, startScreenRoute,
                      //     arguments: StartScreen(
                      //       currentScreen: 'home',
                      //       mode: 2,
                      //     ));
                    },
                    child: Padding(
                      padding: currentLocale.languageCode == 'en'
                          ? EdgeInsets.only(
                              left:
                                  MediaQuery.of(context).size.width / 2 - 77.5)
                          : EdgeInsets.only(
                              right:
                                  MediaQuery.of(context).size.width / 2 - 77.5),
                      child: Container(
                        height: 110,
                        width: 155,
                        decoration: BoxDecoration(
                            color: Color(0xffcccccc),
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('FullFeatured')!,
                            style: rockwellReg30,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final dynamic _tooltip = _tooltipKey.currentState;
                      _tooltip.ensureTooltipVisible();
                    },
                    child: Tooltip(
                      key: _tooltipKey,
                      message: AppLocalizations.of(context)!
                          .translate("GameModeTooltipText")!,
                      height: 30,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      padding: EdgeInsets.all(10),
                      textStyle: TextStyle(fontSize: 15, color: Colors.white),
                      showDuration: Duration(seconds: 30),
                      child: Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        child:
                            Icon(Icons.help, size: 40, color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
