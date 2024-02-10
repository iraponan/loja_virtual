import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/config/firebase_options.dart';
import 'package:loja_virtual/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: 'Flutter´s Clothing',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: const Color.fromARGB(255, 4, 125, 141),
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}