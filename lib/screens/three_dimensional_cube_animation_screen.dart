import 'package:flutter/material.dart';
import 'package:flutter_animations/utils/app_texts.dart';
import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreeDimensionalCubeAnimationScreen extends StatefulWidget {
  const ThreeDimensionalCubeAnimationScreen({super.key});

  @override
  State<ThreeDimensionalCubeAnimationScreen> createState() =>
      _ThreeDimensionalCubeAnimationScreenState();
}

class _ThreeDimensionalCubeAnimationScreenState
    extends State<ThreeDimensionalCubeAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _xAnimationController;
  late AnimationController _yAnimationController;
  late AnimationController _zAnimationController;
  late Tween<double> _animation;

  final widthAndHeight = 100.0;

  @override
  void initState() {
    super.initState();

    _xAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _yAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _zAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    _xAnimationController.dispose();
    _yAnimationController.dispose();
    _zAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xAnimationController
      ..reset()
      ..repeat();
    _yAnimationController
      ..reset()
      ..repeat();
    _zAnimationController
      ..reset()
      ..repeat();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.threeDimensionalCubeAnimation),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: Listenable.merge([
                  _xAnimationController,
                  _yAnimationController,
                  _zAnimationController
                ]),
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(_animation.evaluate(_xAnimationController))
                      ..rotateY(_animation.evaluate(_yAnimationController))
                      ..rotateZ(_animation.evaluate(_zAnimationController)),
                    child: Stack(
                      children: [
                        //back
                        Transform(
                          transform: Matrix4.identity()
                            ..translate(Vector3(0, 0, -widthAndHeight)),
                          child: Container(
                            width: widthAndHeight,
                            height: widthAndHeight,
                            color: Colors.purple,
                          ),
                        ),
                        //left
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..rotateY(pi/2),
                          child: Container(
                            width: widthAndHeight,
                            height: widthAndHeight,
                            color: Colors.red,
                          ),
                        ),
                        //right
                        Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()
                            ..rotateY(-pi/2),
                          child: Container(
                            width: widthAndHeight,
                            height: widthAndHeight,
                            color: Colors.blue,
                          ),
                        ),
                        //top
                        Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()
                            ..rotateX(-pi/2),
                          child: Container(
                            width: widthAndHeight,
                            height: widthAndHeight,
                            color: Colors.orange,
                          ),
                        ),
                        //bottom
                        Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..rotateX(pi/2),
                          child: Container(
                            width: widthAndHeight,
                            height: widthAndHeight,
                            color: Colors.brown,
                          ),
                        ),
                        //front
                        Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.green,
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
