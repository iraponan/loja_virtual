import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.productData});

  final ProductData productData;

  @override
  State<ProductPage> createState() =>
      _ProductPageState(productData: productData);
}

class _ProductPageState extends State<ProductPage> {
  _ProductPageState({required this.productData});

  final ProductData productData;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title ?? ''),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: AnotherCarousel(
              animationDuration: const Duration(seconds: 1),
              autoplayDuration: const Duration(seconds: 5),
              images: productData.images!.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotBgColor: Colors.transparent,
              dotIncreasedColor: primaryColor,
              dotSpacing: 15.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  productData.title ?? '',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${productData.price?.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
