import 'package:flutter/material.dart';
import 'package:mvvmclean/app/app.dart';
import 'package:mvvmclean/app/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  runApp(MyApp());
}
