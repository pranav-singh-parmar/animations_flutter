
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

extension DelayedExtension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}