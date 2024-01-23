import 'package:flutter/material.dart';
import 'package:flutter_animations/models/person_model.dart';

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
    return const Placeholder();
  }
}
