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
      case defaultGameRoute3x3:
        return MaterialPageRoute(builder: (_) => Game(1));
      case defaultGameRoute4x4:
        return MaterialPageRoute(builder: (_) => Game(2));
      case defaultGameRoute5x5:
        return MaterialPageRoute(builder: (_) => Game(3));
      case enhancedGameRoute3x3:
        return MaterialPageRoute(builder: (_) => GameV2(1));
      case enhancedGameRoute4x4:
        return MaterialPageRoute(builder: (_) => GameV2(2));
      case enhancedGameRoute5x5:
        return MaterialPageRoute(builder: (_) => GameV2(3));
      case startScreenRoute:
        return MaterialPageRoute(builder: (_) => StartScreen());
      case gameOver:
        final GameOver args = settings.arguments as GameOver;
        return MaterialPageRoute(
            builder: (_) => GameOver(
                  args.finalScore,
                  timeIsUp: args.timeIsUp,
                ));
    }

    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}
