import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/utils/app_constants.dart' show AppColors;
import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:animations_flutter/utils/app_texts.dart';

class BoxCustomAnimationScreen extends StatefulWidget {
  const BoxCustomAnimationScreen({super.key});

  @override
  State<BoxCustomAnimationScreen> createState() => _BoxCustomAnimationScreenState();
}

class _BoxCustomAnimationScreenState extends State<BoxCustomAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late AnimationController _yanimationController;
  late AnimationController _zanimationController;

  late AnimationController _offsetAnimationController;
  late AnimationController _sizeAnimationController;

  late Tween<double> _animation;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _yanimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _zanimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _offsetAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _sizeAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, -4), end: const Offset(0, 1))
            .animate(CurvedAnimation(
                parent: _offsetAnimationController, curve: Curves.easeInOut));
    _sizeAnimation = Tween<double>(begin: 50, end: 180)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_sizeAnimationController);

//tween can be read as between
    _animation = Tween<double>(begin: 0, end: pi * 2);
    _animationController.repeat();
    _yanimationController.repeat();
    _zanimationController.repeat();
// _offsetAnimationController.repeat();
// _sizeAnimationController.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _offsetAnimationController.repeat(reverse: true);
    _sizeAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _yanimationController.dispose();
    _zanimationController.dispose();
    _offsetAnimationController.dispose();
    _sizeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleString: AppTexts.boxCustomAnimation,
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: Listenable.merge([
              _animationController,
              _yanimationController,
              _zanimationController,
              _offsetAnimationController,
              _sizeAnimationController
            ]),
            builder: (context, widget) {
              return SlideTransition(
                  position: _offsetAnimation,
                  child: Transform(
                      alignment: Alignment
                          .center, //the point around which transformation will be happening
                      transform: Matrix4.identity()
                        ..rotateX(_animation.evaluate(_animationController))
                        ..rotateY(_animation.evaluate(_yanimationController))
                        ..rotateZ(_animation.evaluate(_zanimationController)),
                      child: Container(
                        width: _sizeAnimation.value,
                        height: _sizeAnimation.value,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 3))
                            ]),
                      )));
            }),
      ),
    );
  }
}
