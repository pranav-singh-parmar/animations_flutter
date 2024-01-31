import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/screens/widgets/custom_elevated_button.dart';
import 'package:animations_flutter/utils/app_constants.dart';
import 'package:animations_flutter/utils/app_texts.dart';
import 'package:flutter/material.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen>
    with SingleTickerProviderStateMixin {
  final borderRadius = 20.0;

  late AnimationController _animationController;
  late Animation<double> _iconScalableAnimation;
  late Animation<double> _containerScalableAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -0.23))
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut));

    _iconScalableAnimation = Tween<double>(begin: 4.5, end: 3.5).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _containerScalableAnimation = Tween<double>(begin: 2.5, end: 0.4).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _restartAnimation();
    return Scaffold(
        appBar: const CustomAppBar(titleString: AppTexts.promptScreen),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(borderRadius),
              //  child:
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: AppColors.blackColor,
                ),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 100,
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    child: Stack(alignment: Alignment.center, children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 75,
                            ),
                            Text(
                              AppTexts.title,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              AppTexts.subtitle,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                          child: SlideTransition(
                        position: _offsetAnimation,
                        child: ScaleTransition(
                          scale: _containerScalableAnimation,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                            child: ScaleTransition(
                              scale: _iconScalableAnimation,
                              child: const Icon(Icons.check),
                            ),
                          ),
                        ),
                      ))
                    ])),
              ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CustomElevatedButton(
                  onPressed: _restartAnimation,
                  title: AppTexts.restartAnimation,
                ),
              )
            ],
          ),
        ));
  }

  void _restartAnimation() {
    _animationController
      ..reset()
      ..forward();
  }
}
