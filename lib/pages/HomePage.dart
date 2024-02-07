import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/home_tab.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        HomeTab(),
      ],
    );
  }
}

