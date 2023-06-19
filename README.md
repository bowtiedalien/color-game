# ColorGame

| created by | Sara (bowtiedalien) |
|---|---|
| birth year | April, 2021 |
| tech used | Flutter |

## Description
Project 1 in Mobile Programming Course - CSE0406, IKU.

<span style="color: orange;">ColorGame</span> is a fun little game built with Flutter. You choose a level, then you start getting random colors which you're supposed to spot and click on in the color grid. If you choose the correct color, your score increases and you keep playing until time's up (which is 60 seconds in each level). If you choose the wrong color, game's over.

The game has 3 difficulty levels: 3x3, 4x4 and 5x5.
The higher the difficulty level, the larger the color grid and the harder it is to spot the color in question. This is a good time to train your eyesight 👀

## Features
- Flutter Localisation. Interface is implemented in AR and EN.
- Has three difficulty levels 
- You can play it to test if you're color-blind 😁

## Mockups

All Mockups:
> `./designs`

### Example Screens: 
<p float="left">
  <img src="designs\GameScreen(3x3).png" width="200" />
  <img src="designs\GameOver(Win).png" width="200" /> 
</p>

## Dev References

- [Random Color Generator - see third answer](https://stackoverflow.com/questions/51340588/flutter-how-can-i-make-a-random-color-generator-background/51341167)
- [Flutter GridView and ListView](https://medium.com/flutterfly-tech/flutter-listview-gridview-ce7177812b1d)
- [Yellow lines appearing under text = just add Scaffold as parent widget](https://stackoverflow.com/questions/47114639/yellow-lines-under-text-widgets-in-flutter)
- [GestureDetector onTap gets triggered automatically](https://stackoverflow.com/questions/50049683/flutter-gesturedetector-ontap-gets-triggered-automatically-how-to)
- [Random Colors in Flutter - method 1](https://www.kindacode.com/article/ways-to-create-random-colors-in-flutter/)
- [Get a random number inside a range in dart](https://stackoverflow.com/questions/13318207/how-to-get-a-random-number-from-range-in-dart)
- [Know which button is tapped](https://stackoverflow.com/questions/53152881/how-to-know-which-button-is-tapped-in-flutter)
- [How to Make a Timer in Flutter](https://www.youtube.com/watch?v=uPhhEgpyVY8)
- [IconButton not working when using alignment](https://stackoverflow.com/questions/51584388/flutter-iconbutton-not-working-when-using-alignment-or-margin-or-padding)
- [change width/padding of dropdownbutton](https://stackoverflow.com/questions/48895195/how-can-we-change-the-width-padding-of-a-flutter-dropdownmenuitem-in-a-dropdown)
- [Make AppBar transparent and show background behind it](https://stackoverflow.com/questions/53080186/make-appbar-transparent-and-show-background-image-which-is-set-to-whole-screen)
- [Internationalization, adding the icon and changing the lang, great tutorial](https://www.youtube.com/watch?v=leUDOBak2NA&list=PLyHn8N5MSsgEfPAxCytQDPATDlHwpP5rE&index=4)
- [How to pause Countdown timer](https://stackoverflow.com/questions/55384326/pause-flutter-countdown-timer)
- [Timer clock app](https://www.youtube.com/watch?v=4Zbf-PS9Q84)
- [\*\*\*Play an Audio from Local Asset - was my last solution after a lot of fruitless debugging - worked immediately](https://www.youtube.com/watch?v=apAtBy17TK4)
- [\*\*\*Shared Preferences in 5 minutes - Very Helpful](https://www.youtube.com/watch?v=uyz0HrGUamc)
- [Audio Player decided to give up](https://stackoverflow.com/questions/66009675/audio-player-decides-to-give-up-flutter-audio-cache)
- [Where I got clock ticking mp3](https://www.fesliyanstudios.com/royalty-free-sound-effects-download/clock-ticking-46)
- [Immediate link to clock ticking sound mp3](https://www.fesliyanstudios.com/play-mp3/2400)
- [ISO Language Code Table](http://www.lingoes.net/en/translator/langcode.htm)
- [Emoji of all country flags](https://flagpedia.net/emoji)
- [docs of `Navigator.pushNamed`](https://api.flutter.dev/flutter/widgets/Navigator/pushNamed.html)
- [how to pass arguments with `settings.arguments`](https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments) - see the implementation in the last switch-case in `custom_router.dart`
- [Prevent dialog from closing on outside touch](https://stackoverflow.com/questions/50649006/prevent-dialog-from-closing-on-outside-touch-in-flutter)
- [override back button in Flutter](https://stackoverflow.com/questions/49356664/how-to-override-the-back-button-in-flutter)
- [get locale of current context](https://stackoverflow.com/questions/50923906/how-to-get-timezone-language-and-county-id-in-flutter-by-the-location-of-device)
- [lovely explanation of `initState` and `build` method (video) - The Net Ninja](https://www.youtube.com/watch?v=pDzQGolJayE)
- [solution: timer is glitchy issue, first answer](https://stackoverflow.com/questions/49952901/flutter-timer-issue-during-testing)
- [How to programmatically exit the app, first answer](https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app)
- [enable tooltip on tap rather than on pressed, second answer](https://stackoverflow.com/questions/59826172/tooltip-ontap-rather-than-onlongpress-possible)
- [Great tutorial on Routing (video) - PodCoder](https://www.youtube.com/watch?v=1jhiXTgY-ko)
- [acceptable explanation of onGenerateRoute and onUnknownRoute (video) - mtechviral](https://www.youtube.com/watch?v=vyXWqOmkxe8)

## To create apk

- for debug apk
  `flutter build apk`
- for release apk
  `flutter build apk --release`
- for app bundle
  `flutter build appbundle`