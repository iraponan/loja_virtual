import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(orderId),
    );
  }
}
