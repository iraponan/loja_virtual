import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderProductContent extends StatelessWidget {
  const OrderProductContent({super.key, required this.snapshot});

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    String text = 'Descrição:\n';
    for (LinkedHashMap p in snapshot.get('products')) {
      text += '${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n';
    }
    text += 'Total: R \$ ${snapshot.get('totalPrice').toStringAsFixed(2)}';
    return Text(text);
  }
}
