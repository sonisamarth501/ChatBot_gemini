import 'package:flutter/material.dart';
import 'package:flutter_bot/core/app.dart';
import 'package:flutter_bot/injection_container.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}
