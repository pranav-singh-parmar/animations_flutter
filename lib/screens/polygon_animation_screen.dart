import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/screens/widgets/polygon.dart';
import 'package:animations_flutter/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class PolygonAnimationScreen extends StatefulWidget {
  const PolygonAnimationScreen({super.key});

  @override
  State<PolygonAnimationScreen> createState() => _PolygonAnimationScreenState();
}

class _PolygonAnimationScreenState extends State<PolygonAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _sidesAC;
  late Animation<int> _sidesAnimation;

  late AnimationController _sizeAC;
  late Animation<double> _sizeAnimation;

  late AnimationController _rotationAC;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _sidesAC = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _sidesAnimation = IntTween(begin: 3, end: 10).animate(_sidesAC);

    _sizeAC = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _sizeAnimation = Tween<double>(begin: 20.0, end: 400)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_sizeAC);

    _rotationAC =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_rotationAC);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sidesAC.repeat(reverse: true);
    _sizeAC.repeat(reverse: true);
    _rotationAC.repeat(reverse: true);
  }

  @override
  void dispose() {
    _sidesAC.dispose();
    _sizeAC.dispose();
    _rotationAC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleString: AppTexts.polygonAnimationScreen),
      body: Center(
          child: AnimatedBuilder(
              animation: Listenable.merge(
                  [_sidesAnimation, _sizeAnimation, _rotationAnimation]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_rotationAnimation.value)
                    ..rotateY(_rotationAnimation.value)
                    ..rotateZ(_rotationAnimation.value),
                  child: CustomPaint(
                      painter: Polygon(sides: _sidesAnimation.value),
                      child: SizedBox(
                        width: _sizeAnimation.value,
                        height: _sizeAnimation.value,
                      )),
                );
              })),
    );
  }
}
