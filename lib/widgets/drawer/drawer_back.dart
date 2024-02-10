import 'package:flutter/material.dart';

class DrawerBack extends StatelessWidget {
  const DrawerBack({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDrawerBack();
  }
}


Widget _buildDrawerBack() => Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 203, 236, 241),
        Colors.white,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
);