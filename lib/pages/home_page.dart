import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/category/category_detail_page.dart';
import 'package:loja_virtual/widgets/cart/cart_button.dart';
import 'package:loja_virtual/widgets/drawer/custom_drawer.dart';
import 'package:loja_virtual/widgets/home_tab.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: const HomeTab(),
          drawer: CustomDrawer(
            pageController: _pageController,
          ),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Produtos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: const CategoryDetailPage(),
          floatingActionButton: const CartButton(),
        ),
      ],
    );
  }
}
