import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'canteen_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: CanteenHome(l: '',)));
}
