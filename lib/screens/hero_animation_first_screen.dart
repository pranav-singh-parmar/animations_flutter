import 'package:animations_flutter/screens/hero_animation_second_screen.dart';
import 'package:animations_flutter/screens/widgets/custom_app_bar.dart';
import 'package:animations_flutter/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:animations_flutter/models/person_model.dart';

class HeroAnimationFirstScreen extends StatefulWidget {
  const HeroAnimationFirstScreen({super.key});

  @override
  State<HeroAnimationFirstScreen> createState() =>
      _HeroAnimationFirstScreenState();
}

class _HeroAnimationFirstScreenState extends State<HeroAnimationFirstScreen> {
  final people = const [
    PersonModel(name: 'John', age: 20, emoji: '🙋🏻‍♂️'),
    PersonModel(name: 'Jane', age: 21, emoji: '👸🏽'),
    PersonModel(name: 'Jack', age: 22, emoji: '🧔🏿‍♂️'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleString: AppTexts.heroAnimationFirstScreen,
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final personModel = people[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HeroAnimationSecondScreen(
                    personModel: personModel,
                  ),
                ),
              );
            },
            leading: Hero(
              tag: personModel.name,
              child: Text(
                personModel.emoji,
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            title: Text(personModel.name),
            subtitle: Text(
              '${personModel.age} years old',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          );
        },
      ),
    );
  }
}
