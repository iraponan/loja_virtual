import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/config/firebase_options.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/pages/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScopedModel<UserModel>(
    model: UserModel(),
    child: ScopedModelDescendant<UserModel>(
      builder: (BuildContext context, Widget? child, UserModel model) {
        return ScopedModel<CartModel>(
          model: CartModel(model),
          child: MaterialApp(
            title: 'Flutter´s Clothing',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: const Color.fromARGB(255, 4, 125, 141),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 4, 125, 141),
                foregroundColor: Colors.white,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          ),
        );
      },
    ),
  ));
}