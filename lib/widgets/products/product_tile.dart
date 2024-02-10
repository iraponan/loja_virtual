import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.type, required this.data});

  final String type;
  final ProductData data;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
