import 'package:animations_flutter/screens/animated_container_screen.dart';
import 'package:animations_flutter/screens/auto_color_updating_circle_screen.dart';
import 'package:animations_flutter/screens/hero_animation_first_screen.dart';
import 'package:animations_flutter/screens/polygon_animation_screen.dart';
import 'package:animations_flutter/screens/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:animations_flutter/screens/spin_and_flip_animation.dart';
import 'package:animations_flutter/screens/simple_animation_screen.dart';
import 'package:animations_flutter/screens/three_dimensional_cube_animation_screen.dart';
import 'package:animations_flutter/utils/app_texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.home),
      ),
      body: Center(
        child: Column(
          children: [
            CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SimpleAnimationScreen()),
                  );
                },
                title: AppTexts.simpleAnimation),
            CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SpinAndFlipAnimationScreen()),
                  );
                },
                title: AppTexts.spinAndFlipAnimation),
            CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ThreeDimensionalCubeAnimationScreen()),
                  );
                },
                title: AppTexts.threeDimensionalCubeAnimation),
            CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HeroAnimationFirstScreen()),
                  );
                },
                title: AppTexts.heroAnimationFirstScreen),
            CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnimatedContainerScreen()),
                  );
                },
                title: AppTexts.animatedContainerScreen),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AutoColorUpdatingCircleScreen()),
                  );
                },
                title: AppTexts.autoColorUpdatingCircleScreen),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PolygonAnimationScreen()),
                  );
                },
                title: AppTexts.polygonAnimationScreen)
          ],
        ),
      ),
    );
  }
}
