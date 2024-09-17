import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/utils/app_constants.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:animations_flutter/utils/app_texts.dart';
import 'dart:math' show pi;
import 'package:animations_flutter/utils/extensions.dart' show DelayedExtension;
import 'package:animations_flutter/screens/widgets/circle_clipper.dart' show CircleClipperEnum, CircleClipper;

class SpinAndFlipAnimationScreen extends StatefulWidget {
  const SpinAndFlipAnimationScreen({super.key});

  @override
  State<SpinAndFlipAnimationScreen> createState() => _SpinAndFlipAnimationScreenState();
}

class _SpinAndFlipAnimationScreenState extends State<SpinAndFlipAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _antiClockwiseAC;
  late Animation _antiClockwiseAnimation;

  late AnimationController _flipAC;
  late Animation _flipAnimation;

  @override
  void initState() {
    super.initState();
    _antiClockwiseAC =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _antiClockwiseAnimation = Tween<double>(begin: 0, end: -pi / 2).animate(
        CurvedAnimation(parent: _antiClockwiseAC, curve: Curves.bounceOut));

    // _antiClockwiseAC.repeat();

    _flipAC =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _flipAnimation = Tween<double>(begin: 0, end: pi)
        .animate(CurvedAnimation(parent: _flipAC, curve: Curves.bounceOut));

    _antiClockwiseAC.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(CurvedAnimation(parent: _flipAC, curve: Curves.bounceOut));

        _flipAC
          ..reset()
          ..forward();
      }
    });

    _flipAC.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _antiClockwiseAnimation = Tween<double>(
                begin: _antiClockwiseAnimation.value,
                end: _antiClockwiseAnimation.value - (pi / 2))
            .animate(CurvedAnimation(
                parent: _antiClockwiseAC, curve: Curves.bounceOut));

        _antiClockwiseAC
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _antiClockwiseAC.dispose();
    _flipAC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _antiClockwiseAC
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));

    return Scaffold(
      appBar: const CustomAppBar(
        titleString: AppTexts.spinAndFlipAnimation,
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: _antiClockwiseAC,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(_antiClockwiseAnimation.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                        animation: _flipAC,
                        builder: (context, child) {
                          return Transform(
                              alignment: Alignment.centerRight,
                              transform: Matrix4.identity()
                                ..rotateY(_flipAnimation.value),
                              child: ClipPath(
                                clipper: const CircleClipper(
                                    circleSideEnum: CircleClipperEnum.leftTitledSemiCircle),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: AppColors.blueColor,
                                ),
                              ));
                        }),
                    AnimatedBuilder(
                        animation: _flipAC,
                        builder: (context, child) {
                          return Transform(
                              alignment: Alignment.centerLeft,
                              transform: Matrix4.identity()
                                ..rotateY(_flipAnimation.value),
                              child: ClipPath(
                                  clipper: const CircleClipper(
                                      circleSideEnum: CircleClipperEnum.rightTitledSemiCircle),
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      color: AppColors.yellowColor)));
                        }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

