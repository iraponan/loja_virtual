import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu carrinho'),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (BuildContext context, Widget? child, CartModel model) {
                int p = model.products.length;
                return Text(
                  '${p ?? 0} ${p == 1 ? 'ITEM' : 'ITENS'}',
                  style: const TextStyle(
                    fontSize: 17.0
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
