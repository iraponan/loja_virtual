import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/cart/cart_button.dart';
import 'package:loja_virtual/widgets/drawer/drawer_custom.dart';
import 'package:loja_virtual/widgets/tabs/tab_home.dart';
import 'package:loja_virtual/widgets/tabs/tab_orders.dart';
import 'package:loja_virtual/widgets/tabs/tab_places.dart';
import 'package:loja_virtual/widgets/tabs/tab_products.dart';

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
          body: const ProductsTab(),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Lojas'),
            centerTitle: true,
          ),
          body: const PlacesTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Meus Pedidos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: const OrdersTab(),
          //floatingActionButton: const CartButton(),
        ),
      ],
    );
  }
}
