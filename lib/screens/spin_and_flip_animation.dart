import 'package:flutter/material.dart';
import 'package:flutter_animations/utils/app_texts.dart';
import 'dart:math' show pi;

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
      appBar: AppBar(
        title: const Text(AppTexts.spinAndFlipAnimation),
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
                                clipper: const HalfCircleClipper(
                                    circleSideEnum: CircleSideEnum.left),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.blue,
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
                                  clipper: const HalfCircleClipper(
                                      circleSideEnum: CircleSideEnum.right),
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.yellow)));
                        }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

enum CircleSideEnum { left, right }

extension CircleSideEnumEx on CircleSideEnum {
  Path toPath(Size size) {
    final path = Path();
    Offset offset;
    bool clockwise = false;
    switch (this) {
      case CircleSideEnum.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSideEnum.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);

    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSideEnum circleSideEnum;

  const HalfCircleClipper({required this.circleSideEnum});

  @override
  Path getClip(Size size) => circleSideEnum.toPath(size);

  /* 
  this function tells that when changes happen to parent widget, should clip path be redrawn
  set it to true becuase size may vary
  */
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}
