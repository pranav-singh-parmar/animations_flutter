import 'package:animations_flutter/screens/widgets/custom_elevated_button.dart';
import 'package:animations_flutter/utils/app_constants.dart'
    show NavigationEnum;
import 'package:flutter/material.dart';
import 'package:animations_flutter/utils/app_texts.dart';
import 'package:animations_flutter/utils/extensions.dart'
    show NavigationEnumExtension;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<NavigationEnum> _navigationList = [
    NavigationEnum.simpleAnimation,
    NavigationEnum.spinAndFlipAnimation,
    NavigationEnum.threeDimensionalCubeAnimation,
    NavigationEnum.heroAnimationFirst,
    NavigationEnum.animatedContainer,
    NavigationEnum.autoColorUpdatingCirle,
    NavigationEnum.polygonAnimation,
    NavigationEnum.drawerAnimation,
    NavigationEnum.prompt,
    NavigationEnum.boxCustomAnimation,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.home),
      ),
      body: Center(
          child: ListView.builder(
        shrinkWrap: true,
        itemCount: _navigationList.length,
        itemBuilder: _listElement,
      )),
    );
  }

  Widget _listElement(BuildContext context, int index) {
    final navigationEnum = _navigationList[index];
    return Center(
      child: CustomElevatedButton(
          onPressed: () {
            // Navigator.push(context, route)
            Navigator.of(context).navigateTo(navigationEnum);
          },
          title: getTitleFor(navigationEnum)),
    );
  }

  String getTitleFor(NavigationEnum navigationEnum) {
    switch (navigationEnum) {
      case NavigationEnum.simpleAnimation:
        return AppTexts.simpleAnimation;
      case NavigationEnum.spinAndFlipAnimation:
        return AppTexts.spinAndFlipAnimation;
      case NavigationEnum.threeDimensionalCubeAnimation:
        return AppTexts.threeDimensionalCubeAnimation;
      case NavigationEnum.heroAnimationFirst:
        return AppTexts.heroAnimationFirstScreen;
      case NavigationEnum.animatedContainer:
        return AppTexts.animatedContainerScreen;
      case NavigationEnum.autoColorUpdatingCirle:
        return AppTexts.autoColorUpdatingCircleScreen;
      case NavigationEnum.polygonAnimation:
        return AppTexts.polygonAnimationScreen;
      case NavigationEnum.drawerAnimation:
        return AppTexts.drawerAnimationScreen;
      case NavigationEnum.prompt:
        return AppTexts.promptScreen;
        case NavigationEnum.boxCustomAnimation:
        return AppTexts.boxCustomAnimation;
      default:
        return "";
    }
  }
}
