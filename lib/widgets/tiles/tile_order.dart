import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/order/order_product_content.dart';
import 'package:loja_virtual/widgets/order/order_product_status.dart';

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
              int status = snapshot.data?['status'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código do Pedido: ${snapshot.data?.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  OrderProductContent(
                    snapshot: snapshot.data!,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Text(
                    'Status do Pedido:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OrderProductStatus(
                        title: '1',
                        subtitle: 'Preparação',
                        status: status,
                        thisStatus: 1,
                      ),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.green[500],
                      ),
                      OrderProductStatus(
                        title: '2',
                        subtitle: 'Transporte',
                        status: status,
                        thisStatus: 2,
                      ),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.green[500],
                      ),
                      OrderProductStatus(
                        title: '3',
                        subtitle: 'Entrega',
                        status: status,
                        thisStatus: 3,
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
