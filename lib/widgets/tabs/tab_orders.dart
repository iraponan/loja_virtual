import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/model_user.dart';
import 'package:loja_virtual/pages/page_login.dart';
import 'package:loja_virtual/widgets/tiles/tile_order.dart';
import 'package:scoped_model/scoped_model.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (BuildContext context, Widget? child, UserModel model) {
        if (UserModel.of(context).isLoggedIn()) {
          String? uid = UserModel.of(context).firebaseUser?.uid;
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('orders')
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: snapshot.data!.docs
                      .map((doc) => OrderTile(
                            orderId: doc.id,
                          ))
                      .toList().reversed.toList(),
                );
              }
            },
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.list_alt_rounded,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  'Faça o login para acompanhar seus pedidos!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
