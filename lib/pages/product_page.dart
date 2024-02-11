import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.productData});

  final ProductData productData;

  @override
  State<ProductPage> createState() => _ProductPageState(productData: productData);
}

class _ProductPageState extends State<ProductPage> {
  _ProductPageState({required this.productData});

  final ProductData productData;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
