import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(orderId)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Text(
                    'Código do Pedido: ${snapshot.data?.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
