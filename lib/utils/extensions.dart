import 'package:animations_flutter/models/person_model.dart';
import 'package:animations_flutter/screens/animated_container_screen.dart';
import 'package:animations_flutter/screens/auto_color_updating_circle_screen.dart';
import 'package:animations_flutter/screens/drawer_animation_screen.dart';
import 'package:animations_flutter/screens/hero_animation_first_screen.dart';
import 'package:animations_flutter/screens/hero_animation_second_screen.dart';
import 'package:animations_flutter/screens/home_screen.dart';
import 'package:animations_flutter/screens/polygon_animation_screen.dart';
import 'package:animations_flutter/screens/simple_animation_screen.dart';
import 'package:animations_flutter/screens/spin_and_flip_animation_screen.dart';
import 'package:animations_flutter/screens/three_dimensional_cube_animation_screen.dart';
import 'package:animations_flutter/utils/app_constants.dart'
    show NavigationEnum;
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

extension DelayedExtension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

extension NavigationEnumExtension on NavigatorState {
  void navigateTo(NavigationEnum navigationEnum, {dynamic parameters}) {
    Widget? screen;
    switch (navigationEnum) {
      case NavigationEnum.home:
        screen = const HomeScreen();
        break;
      case NavigationEnum.simpleAnimation:
        screen = const SimpleAnimationScreen();
        break;
      case NavigationEnum.spinAndFlipAnimation:
        screen = const SpinAndFlipAnimationScreen();
        break;
      case NavigationEnum.threeDimensionalCubeAnimation:
        screen = const ThreeDimensionalCubeAnimationScreen();
        break;
      case NavigationEnum.heroAnimationFirst:
        screen = const HeroAnimationFirstScreen();
        break;
      case NavigationEnum.heroAnimationSecond:
        if (parameters is PersonModel) {
          screen = HeroAnimationSecondScreen(personModel: parameters);
        }
        break;
      case NavigationEnum.animatedContainer:
        screen = const AnimatedContainerScreen();
        break;
      case NavigationEnum.autoColorUpdatingCirle:
        screen = const AutoColorUpdatingCircleScreen();
        break;
      case NavigationEnum.polygonAnimation:
        screen = const PolygonAnimationScreen();
        break;
      case NavigationEnum.drawerAnimation:
        screen = const DrawerAnimationScreen();
        break;
    }

    if (screen != null) {
      push(
        MaterialPageRoute(builder: (context) => screen!),
      );
    } else {
      "Value not set for $navigationEnum in navigateWith function".log();
    }
  }
}
