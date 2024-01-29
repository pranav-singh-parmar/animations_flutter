import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/utils/app_constants.dart' show AppColors;
import 'package:animations_flutter/utils/app_texts.dart';
import 'package:flutter/material.dart';

class DrawerAnimationScreen extends StatefulWidget {
  const DrawerAnimationScreen({super.key});

  @override
  State<DrawerAnimationScreen> createState() => _DrawerAnimationScreenState();
}

class _DrawerAnimationScreenState extends State<DrawerAnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          titleString: AppTexts.animatedContainerScreen,
        ),
        body: Center(
            child: Container(
          height: 100,
          width: 100,
          color: AppColors.blackColor,
        )));
  }
}
