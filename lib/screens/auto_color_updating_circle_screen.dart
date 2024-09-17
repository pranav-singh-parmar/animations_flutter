import 'package:animations_flutter/screens/widgets/circle_clipper.dart'
    show CircleClipper, CircleClipperEnum;
import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AutoColorUpdatingCircleScreen extends StatefulWidget {
  const AutoColorUpdatingCircleScreen({super.key});

  @override
  State<AutoColorUpdatingCircleScreen> createState() =>
      _AutoColorUpdatingCircleScreenState();
}

class _AutoColorUpdatingCircleScreenState
    extends State<AutoColorUpdatingCircleScreen> {
  Color _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          titleString: AppTexts.autoColorUpdatingCircleScreen),
      body: Center(
        child: ClipPath(
          clipper: const CircleClipper(
              circleSideEnum: CircleClipperEnum.completeCircle),
          child: TweenAnimationBuilder(
            tween: ColorTween(
              begin: _getRandomColor(),
              end: _color,
            ),
            onEnd: () {
              setState(() {
                _color = _getRandomColor();
              });
            },
            duration: const Duration(seconds: 1),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              color: Colors.red,
            ),
            builder: (context, Color? color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color!,
                  BlendMode.srcATop,
                ),
                child: child,
              );
              // return Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.width,
              //   color: Colors.red,
              // );
            },
          ),
        ),
      ),
    );
  }

  Color _getRandomColor() => Color(
        0xFF000000 +
            math.Random().nextInt(
              0x00FFFFFF,
            ),
      );
}
