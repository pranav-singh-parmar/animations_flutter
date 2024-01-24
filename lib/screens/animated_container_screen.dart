import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/utils/app_assets.dart';
import 'package:animations_flutter/utils/app_texts.dart';
import 'package:flutter/material.dart';

class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({super.key});

  @override
  State<AnimatedContainerScreen> createState() =>
      _AnimatedContainerScreenState();
}

class _AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  final double _defaultWidth = 100;
  bool _isZoomedIn = false;
  String _buttonTitle = AppTexts.zoomIn;
  double _width = 100;
  Curve _curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleString: AppTexts.animatedContainerScreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 370,
              ),
              width: _width,
              curve: _curve,
              child: Image.asset(
                AppAssets.wallpaper,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isZoomedIn = !_isZoomedIn;
                  _buttonTitle =
                      _isZoomedIn ? AppTexts.zoomOut : AppTexts.zoomIn;
                  _width = _isZoomedIn
                      ? MediaQuery.of(context).size.width
                      : _defaultWidth;
                  _curve = _isZoomedIn ? Curves.bounceInOut : Curves.bounceOut;
                });
              },
              child: Text(
                _buttonTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Color getRandonColor() {
  //   return Color(00X)
  // }
}
