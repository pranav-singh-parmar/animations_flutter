import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/utils/app_constants.dart' show AppColors;
import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:animations_flutter/utils/app_texts.dart';

class SimpleAnimationScreen extends StatefulWidget {
  const SimpleAnimationScreen({super.key});

  @override
  State<SimpleAnimationScreen> createState() => _SimpleAnimationScreenState();
}

class _SimpleAnimationScreenState extends State<SimpleAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    //tween can be read as between
    _animation =
        Tween<double>(begin: 0, end: pi * 2).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CustomAppBar(
        titleString: AppTexts.simpleAnimation,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, widget) {
          return Transform(
            alignment: Alignment.center, //the point around which transformation will be happening
            transform: Matrix4.identity()..rotateZ(_animation.value),
            child: Container(
              height: 100,
              width: 100,
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
            ));
          }
          ),
        ),
      
    );
  }
}
