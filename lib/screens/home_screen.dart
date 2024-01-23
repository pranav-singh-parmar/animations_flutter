import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/spin_and_flip_animation.dart';
import 'package:flutter_animations/screens/simple_animation_screen.dart';
import 'package:flutter_animations/screens/three_dimensional_cube_animation_screen.dart';
import 'package:flutter_animations/utils/app_texts.dart';

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
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SimpleAnimationScreen()),
                  );
                },
                child: const Text(AppTexts.simpleAnimation)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpinAndFlipAnimationScreen()),
                  );
                },
                child: const Text(AppTexts.spinAndFlipAnimation)),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ThreeDimensionalCubeAnimationScreen()),
                  );
                },
                child: const Text(AppTexts.threeDimensionalCubeAnimation))
          ],
        ),
      ),
    );
  }
}
