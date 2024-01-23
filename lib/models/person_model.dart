import 'package:flutter/material.dart';

@immutable
class PersonModel {
  final String name;
  final int age;
  final String emoji;

  const PersonModel({
    required this.name,
    required this.age,
    required this.emoji,
  });
}