import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/data_product.dart';
import 'package:loja_virtual/widgets/tiles/tile_product.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.snapshot});

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.get('title')),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.grid_on,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('products')
              .doc(snapshot.id)
              .collection('itens')
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductData data =
                          ProductData.fromDocument(snapshot.data!.docs[index]);
                      data.category = this.snapshot.id;
                      return ProductTile(
                        type: 'grid',
                        productData: data,
                      );
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(4.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductData data =
                          ProductData.fromDocument(snapshot.data!.docs[index]);
                      data.category = this.snapshot.id;
                      return ProductTile(
                        type: 'list',
                        productData: data,
                      );
                    },
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
