import 'package:colorgame/main.dart';
import 'package:colorgame/routes/route_names.dart';
import 'package:colorgame/screens/game.dart';
import 'package:colorgame/screens/game_fullfeatured.dart';
import 'package:colorgame/screens/game_over.dart';
import 'package:colorgame/screens/not_found.dart';
import 'package:flutter/material.dart';

import '../screens/start_screen.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case defaultGame:
        final Game gameArgs = settings.arguments as Game;
        return MaterialPageRoute(builder: (_) => Game(gameArgs.levelNumber));
      case enhancedGame:
        final GameV2 gameV2Args = settings.arguments as GameV2;
        return MaterialPageRoute(
            builder: (_) => GameV2(gameV2Args.levelNumber));
      case startScreenRoute:
        if (settings.arguments != null) {
          final StartScreen startScreenArgs = settings.arguments as StartScreen;
          return MaterialPageRoute(
              builder: (_) => StartScreen(
                    currentScreen: startScreenArgs.currentScreen,
                    finalScore: startScreenArgs.finalScore,
                    timeWasUp: startScreenArgs.timeWasUp,
                    mode: startScreenArgs.mode,
                    gameLevel: startScreenArgs.gameLevel,
                  ));
        }
        return MaterialPageRoute(builder: (_) => StartScreen());
      case gameOver:
        final GameOver args = settings.arguments as GameOver;
        return MaterialPageRoute(
            builder: (_) => GameOver(
                  args.finalScore,
                  timeIsUp: args.timeIsUp,
                  gameLevel: args.gameLevel,
                ));
    }

    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}
