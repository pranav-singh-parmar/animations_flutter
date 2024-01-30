import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/screens/widgets/custom_drawer.dart';
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
    return CustomDrawer(
        drawer: Material(
          child: Container(
            // color: AppColors.blackColor,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 100, top: 100),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
        child: Scaffold(
            appBar: const CustomAppBar(
              titleString: AppTexts.drawerAnimationScreen,
            ),
            body: Center(
                child: Container(
              height: 100,
              width: 100,
              color: AppColors.blackColor,
            ))));
  }
}
