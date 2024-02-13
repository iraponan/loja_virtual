import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/data_cart_product.dart';
import 'package:loja_virtual/models/model_cart.dart';

class CartProductContent extends StatelessWidget {
  const CartProductContent({super.key, required this.cartProduct});

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    CartModel.of(context).updatePrices();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: 120.0,
          child: Image.network(
            cartProduct.productData?.images![0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cartProduct.productData?.title ?? '',
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Tamanho ${cartProduct.size}',
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  'R\$ ${cartProduct.productData?.price?.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: cartProduct.quantity! > 1 ? () {
                        CartModel.of(context).decProduct(cartProduct);
                      } : null,
                      icon: const Icon(Icons.remove),
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(cartProduct.quantity.toString()),
                    IconButton(
                      onPressed: () {
                        CartModel.of(context).incProduct(cartProduct);
                      },
                      icon: const Icon(Icons.add),
                      color: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      onPressed: () {
                        CartModel.of(context).removeCarItem(cartProduct);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[500],
                      ),
                      child: const Text('Remover'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
